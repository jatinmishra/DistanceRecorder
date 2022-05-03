//
//  DataController.swift
//  DistanceRecorder (iOS)
//
//  Created by Jatin Mishra on 23/04/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: Constants.DISTANCE_RECORDER_DATAMODEL)
    static let shared = DataController()
    
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load \(error.localizedDescription)")
            }            
        }
    }
}
