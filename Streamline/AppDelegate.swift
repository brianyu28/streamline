//
//  AppDelegate.swift
//  Streamline
//
//  Created by Brian Yu on 1/18/23.
//

import Cocoa
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        let workflowGroups = PreferencesController.loadWorkflowGroups()
        AppState.shared.workflowGroups = workflowGroups
        
        let appHasAccessibilityPermissions = EventHandler.checkEventListeningPermissions()
        if appHasAccessibilityPermissions {
            EventHandler.startListeningForSystemEvents()
        }
    }
}
