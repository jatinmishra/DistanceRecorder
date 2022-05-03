//
//  AppState.swift
//  DistanceRecorder (iOS)
//
//  Created by Jatin Mishra on 23/04/22.
//

import SwiftUI

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var tabNavigationTo: Int? = 1
}
