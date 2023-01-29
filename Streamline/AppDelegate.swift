//
//  AppDelegate.swift
//  Streamline
//
//  Created by Brian Yu on 1/18/23.
//

import Cocoa
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        // Don't allow window tabbing
        NSWindow.allowsAutomaticWindowTabbing = false
        
        // Allow hiding app icon from Dock
        let shouldHideAppIconFromDock = UserDefaults.standard.bool(forKey: "shouldHideAppIconFromDock")
        NSApp.setActivationPolicy(shouldHideAppIconFromDock ? .accessory : .regular)
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Load workflow groups from persistent storage
        let workflowGroups = PreferencesController.loadWorkflowGroups()
        AppState.shared.workflowGroups = workflowGroups
        
        // Request accessibility permissions if needed
        let appHasAccessibilityPermissions = EventHandler.checkEventListeningPermissions()
        if appHasAccessibilityPermissions {
            EventHandler.startListeningForSystemEvents()
        }
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        for url in urls {
            GroupExportImport.importWorkflowGroup(url: url)
        }
    }
}
