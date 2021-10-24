//
//  FloweApp.swift
//  Flowe
//
//  Created by Mehmet Yavuz Zenginerler on 10/24/21.
//

import SwiftUI

@main
struct FloweApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
