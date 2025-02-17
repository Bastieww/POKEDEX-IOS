//
//  POKEDEXApp.swift
//  POKEDEX
//
//  Created by Bastien VINCENT-DEKENS on 2/17/25.
//

import SwiftUI

@main
struct POKEDEXApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
