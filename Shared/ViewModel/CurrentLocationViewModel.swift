//
//  CurrentLocationViewModel.swift
//  DistanceRecorder (iOS)
//
//  Created by Jatin Mishra on 23/04/22.
//

import MapKit

// ViewModel to handle getting user location and showing notifications
class CurrentLocationViewModel: NSObject, ObservableObject {
    private var notificationManager = NotificationManager()
    private var counter = 0
    
    enum MapDetails {
        static let baseLocationCoordinate = CLLocationCoordinate2D(latitude: 26.8467, longitude: 80.9462)
        static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    }
    
    // default region coordinates for Lucknow
    @Published var userRegion = MKCoordinateRegion(center: MapDetails.baseLocationCoordinate, span: MapDetails.defaultSpan)
    
    
    var locationManager: CLLocationManager? // optional since user can turn off location services at device level
    
    func initLocationManager() {
        // init location manager if location services is enabled
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.allowsBackgroundLocationUpdates = true
            locationManager?.showsBackgroundLocationIndicator = true
        } else {
            print("Location services are not enabled")
        }
    }
    
    func initNotificationManager() {
        notificationManager.requestAuthorization()
        UNUserNotificationCenter.current().delegate = self
    }
    
    private func checkLocationPermission() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            print("Location restricted")
        case .denied:
            print("Location denied")
        case .authorizedAlways,.authorizedWhenInUse:
            guard let location = locationManager.location else { return }
            userRegion = MKCoordinateRegion(center: location.coordinate, span: MapDetails.defaultSpan)
            if (UserDefaults.standard.bool(forKey: Constants.TRACKING_ENABLED_KEY)) {
                locationManager.startUpdatingLocation()
            }
        @unknown default:
            break
        }
    }
}

// location manager delegate extension
extension CurrentLocationViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermission()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // init distanceTravelled with data stored in local database
        var distanceTravelledInMeters = UserDefaults.standard.double(forKey: Constants.DISTANCE_TRAVELLED_KEY)
        if (distanceTravelledInMeters <= 0) {
            distanceTravelledInMeters = 0.0
        }
        distanceTravelledInMeters += round(locations[0].distance(from: CLLocation(latitude: userRegion.center.latitude, longitude: userRegion.center.longitude)))
        UserDefaults.standard.set(distanceTravelledInMeters, forKey: Constants.DISTANCE_TRAVELLED_KEY)
        
        // save timestamp in local storage when distance travelled is 50 meters from last point
        // since updates are not received every meter so we check in the range 5 meters (done for POC purpose, can be more optimized with testing in various use cases)
        if (round(distanceTravelledInMeters.truncatingRemainder(dividingBy: 50.0)) < 5.0) {
            let distanceDetails = DistanceDetails(context: DataController.shared.container.viewContext)
            distanceDetails.timestamp = Date()
            distanceDetails.distanceTravelled = distanceTravelledInMeters
            try? DataController.shared.container.viewContext.save()
            notificationManager.createLocalNotification()
        }
    }
}

extension CurrentLocationViewModel: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        AppState.shared.tabNavigationTo = 3
        completionHandler()
    }
}
