//
//  CurrentLocationTab.swift
//  DistanceRecorder (iOS)
//
//  Created by Jatin Mishra on 23/04/22.
//

import SwiftUI
import MapKit

struct CurrentLocationTab: View {
    //view model instance
    @StateObject private var currentLocationViewModel = CurrentLocationViewModel()
    @State private var showingAlert = false
    @State private var isEnableTracking = UserDefaults.standard.bool(forKey: Constants.TRACKING_ENABLED_KEY)
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $currentLocationViewModel.userRegion, showsUserLocation: true)
                .onAppear {
                    currentLocationViewModel.initLocationManager()
                    currentLocationViewModel.initNotificationManager()
                }
                .onTapGesture {
                    showingAlert = true
                }
                .alert("Latitude: \($currentLocationViewModel.userRegion.center.latitude.wrappedValue.description) \n Latitude: \($currentLocationViewModel.userRegion.center.longitude.wrappedValue.description)" , isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                }
            
            if !isEnableTracking {
                Text("Please Enable Location Tracking")
            }
                
            Toggle("Enable Tracking", isOn: $isEnableTracking)
                .onTapGesture {
                    UserDefaults.standard.set(!isEnableTracking, forKey: Constants.TRACKING_ENABLED_KEY)
                    isEnableTracking = !isEnableTracking
                    if (isEnableTracking) {
                        currentLocationViewModel.locationManager?.startUpdatingLocation()
                    }
                    else {
                        currentLocationViewModel.locationManager?.stopUpdatingLocation()
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
        }
        
    }
}

struct CurrentLocationTab_Previews: PreviewProvider {
    static var previews: some View {
        CurrentLocationTab()
    }
}
