//
//  ContentView.swift
//  Shared
//
//  Created by Jatin Mishra on 21/04/22.
//
//
//  ContentView.swift
//  DistanceRecorder (iOS)
//
//  Created by Jatin Mishra on 23/04/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var appState = AppState.shared
    
    var body: some View {
        TabView() {
            CurrentLocationTab()
                .tabItem{
                    Image(systemName: "location")
                    Text("Current Location")
                }
                .tag(1)
            DistanceTravelledTab()
                .tabItem{
                    Image(systemName: "chart.bar.xaxis")
                    Text("Stats")
                }
                .tag(2)
            DistanceDetailsListTab()
                .tabItem{
                    Image(systemName: "list.dash")
                    Text("Location Details List")
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
