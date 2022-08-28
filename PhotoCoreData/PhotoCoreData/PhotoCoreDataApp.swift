//
//  PhotoCoreDataApp.swift
//  PhotoCoreData
//
//  Created by App Designer2 on 22.08.22.
//

import SwiftUI

@main
struct PhotoCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
