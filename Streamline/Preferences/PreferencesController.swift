//
//  PreferencesController.swift
//  Streamline
//
//  Created by Brian Yu on 1/22/23.
//

import Foundation

struct PreferencesController {
    
    /** Get the directory to store the app's preferences folder. */
    // TODO: Currently always uses Application Support. Eventually, support alternate locations for Preferences directory.
    static func getPersistentStateDirectory() -> URL? {
        guard let url = getApplicationSupportDirectory()?.appendingPathComponent("WorkflowGroups") else {
            return nil
        }
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        return url
    }
    
    /** Get the app's subdirectory in Application Support, creating it if needed. */
    static func getApplicationSupportDirectory() -> URL? {
        let applicationSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let url = applicationSupportURL.appendingPathComponent("Streamline")
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                return nil
            }
        }
        return url
    }
    
    static func saveWorkflowGroup(workflowGroup: WorkflowGroup) {
        guard let serializedWorkflowGroup = workflowGroup.serialize() else {
            return
        }
        guard let stateDirectory = getPersistentStateDirectory() else {
            return
        }
        let filename = stateDirectory.appendingPathComponent("\(workflowGroup.id).streamline", isDirectory: false)
        do {
            try serializedWorkflowGroup.write(to: filename, atomically: true, encoding: .utf8)
        } catch {
            return
        }
    }
    
}
