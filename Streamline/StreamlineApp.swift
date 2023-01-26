//
//  StreamlineApp.swift
//  Streamline
//
//  Created by Brian Yu on 1/18/23.
//

import SwiftUI

@main
struct StreamlineApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) {
            }
        }
        
    }
}
