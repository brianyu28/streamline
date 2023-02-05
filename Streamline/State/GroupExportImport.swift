//
//  GroupExportImport.swift
//  Streamline
//
//  Created by Brian Yu on 1/28/23.
//

import AppKit
import Foundation

struct GroupExportImport {
    static func showExportSavePanel() -> URL? {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [AppConstants.streamlineFileType]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = true
        savePanel.title = "Export Group"
        savePanel.message = "Choose where to save your group export"
        savePanel.nameFieldLabel = "Filename:"
        
        return savePanel.runModal() == .OK ? savePanel.url : nil
    }
    
    static func showImportPanel() -> URL? {
        let openPanel = NSOpenPanel()
        openPanel.allowedContentTypes = [AppConstants.streamlineFileType]
        openPanel.title = "Import Group"
        openPanel.message = "Choose group to import"
        
        return openPanel.runModal() == .OK ? openPanel.url : nil
    }
    
    static func chooseAndImportWorkflowGroup() {
        if let url = showImportPanel() {
            importWorkflowGroup(url: url)
        }
    }
    
    static func exportWorkflowGroup(workflowGroup: WorkflowGroup) {
        guard let url = showExportSavePanel() else { return }
        guard let serializedGroup = workflowGroup.serialize() else { return }
        try? serializedGroup.write(to: url, atomically: true, encoding: .utf8)
    }
    
    static func importWorkflowGroup(url: URL) {
        guard let text = try? String(contentsOf: url, encoding: .utf8) else { return }
        guard let data = text.data(using: .utf8) else { return }
        let decoder = JSONDecoder()
        guard var workflowGroup = try? decoder.decode(WorkflowGroup.self, from: data) else { return }
        
        if let _ = AppState.shared.workflowGroups.first(where: { $0.id == workflowGroup.id }) {
            let alert = NSAlert()
            alert.messageText = "Importing group: \(workflowGroup.name)"
            alert.informativeText = "A version of this group alrady exists in \(AppConstants.appName). You can replace the existing group or import the file as a new group."
            alert.addButton(withTitle: "Replace Existing Group")
            alert.addButton(withTitle: "Import as New Group")
            alert.addButton(withTitle: "Cancel")
            switch alert.runModal() {
            case .alertFirstButtonReturn:
                AppState.shared.replaceGroupById(workflowGroup: workflowGroup)
                return
            case .alertSecondButtonReturn:
                workflowGroup.regenerateIds()
                AppState.shared.addGroup(workflowGroup: workflowGroup)
                return
            case .alertThirdButtonReturn:
                return
            default:
                return
            }
        } else {
            let alert = NSAlert()
            alert.messageText = "Importing group: \(workflowGroup.name)"
            alert.informativeText = "Confirm whether you'd like to import this group."
            alert.addButton(withTitle: "Import")
            alert.addButton(withTitle: "Cancel")
            switch alert.runModal() {
            case .alertFirstButtonReturn:
                AppState.shared.addGroup(workflowGroup: workflowGroup)
                return
            case .alertSecondButtonReturn:
                return
            default:
                return
            }
        }
    }
}
