//
//  DistanceTravelledTab.swift
//  DistanceRecorder (iOS)
//
//  Created by Jatin Mishra on 23/04/22.
//

import SwiftUI

struct DistanceTravelledTab: View {
    
    @State private var distanceTravelled = UserDefaults.standard.double(forKey: Constants.DISTANCE_TRAVELLED_KEY)
    var body: some View {
        VStack {
            Text("Total Distance Travelled")
                .font(.headline)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 30.0, leading: 0, bottom: 20, trailing: 0))
                .fixedSize()
            Text("\(round(distanceTravelled)) meters")
                .font(.headline)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.center)
                .onAppear {
                    distanceTravelled = UserDefaults.standard.double(forKey: Constants.DISTANCE_TRAVELLED_KEY)
                }
        }
    }
}

struct DistanceTravelledTab_Previews: PreviewProvider {
    static var previews: some View {
        DistanceTravelledTab()
    }
}
