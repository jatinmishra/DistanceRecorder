//
//  DistanceDetailsTab.swift
//  DistanceRecorder (iOS)
//
//  Created by Jatin Mishra on 23/04/22.
//

import SwiftUI

struct DistanceDetailsListTab: View {
    @State private var isEnableTracking = true
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DistanceDetails.timestamp, ascending: true)]) var distanceDetails: FetchedResults<DistanceDetails>
    
    var body: some View {
        VStack {
            Text("Distance Travelled List")
                .font(.headline)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 30.0, leading: 0, bottom: 20, trailing: 0))
                .fixedSize()
            
            List(distanceDetails) { distanceDetails in
                VStack {
                    Text("Distance Travelled -> \(distanceDetails.distanceTravelled)")
                        .padding()
                    Text("Time ->\(distanceDetails.timestamp?.description ?? "")")
                        .padding()
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct DistanceDetailsListTab_Previews: PreviewProvider {
    static var previews: some View {
        DistanceDetailsListTab()
    }
}
