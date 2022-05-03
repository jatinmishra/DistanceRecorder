//
//  DistanceRecorderApp.swift
//  Shared
//
//  Created by Jatin Mishra on 23/04/22.
//

import SwiftUI

@main
struct DistanceRecorderApp: App {
    @StateObject private var dataController = DataController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
