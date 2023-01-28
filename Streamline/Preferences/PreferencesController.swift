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
    
    /** Load workflow groups from persistent storage. */
    static func loadWorkflowGroups() -> [WorkflowGroup] {
        guard let stateDirectory = getPersistentStateDirectory() else {
            return []
        }
        do {
            var results : [WorkflowGroup] = []
            let files = try FileManager.default.contentsOfDirectory(at: stateDirectory, includingPropertiesForKeys: [])
            for file in files {
                guard let text = try? String(contentsOf: file, encoding: .utf8) else { continue }
                guard let data = text.data(using: .utf8) else { continue }
                let decoder = JSONDecoder()
                guard let workflowGroup = try? decoder.decode(WorkflowGroup.self, from: data) else { continue }
                results.append(workflowGroup)
            }
            return results
        } catch {
            return []
        }
    }
    
}
