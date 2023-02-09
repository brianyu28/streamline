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
    
    @State private var debugMode: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if !debugMode {
                ContentView()
            } else {
                DebugView()
            }
        }
        .commands {
            SidebarCommands()
            CommandGroup(replacing: CommandGroupPlacement.newItem) {
            }
            CommandGroup(after: CommandGroupPlacement.help) {
                Button(debugMode ? "Exit Debug Mode" : "Enter Debug Mode") {
                    debugMode = !debugMode
                }
            }
        }
        .handlesExternalEvents(matching: [])
        
        Settings {
            SettingsView()
        }
    }
}
