//
//  MinesweeperApp.swift
//  Minesweeper
//
//  Created by Mehran Ramazanilar on 2/28/1402 AP.
//

import SwiftUI

@main
struct MinesweeperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GameScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
