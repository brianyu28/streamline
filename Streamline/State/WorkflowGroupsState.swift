//
//  WorkflowGroupsState.swift
//  Streamline
//
//  Created by Brian Yu on 1/22/23.
//

import AppKit
import Foundation

extension AppState {
    /** Create a new workflow group. */
    func createNewWorkflowGroup() -> WorkflowGroup {
        let workflowGroup = WorkflowGroup()
        self.workflowGroups.append(workflowGroup)
        self.scheduleSaveWorkflowGroup(workflowGroup: workflowGroup)
        return workflowGroup
    }
    
    /** Add new workflow group to application state. */
    func addGroup(workflowGroup: WorkflowGroup) {
        self.workflowGroups.append(workflowGroup)
        self.scheduleSaveWorkflowGroup(workflowGroup: workflowGroup)
    }
    
    /** Delete a group, removing it from both the current app state and from memory. */
    func deleteGroup(workflowGroup: WorkflowGroup, withConfirmation: Bool = false) -> Bool {
        if withConfirmation {
            let alert = NSAlert()
            alert.messageText = "Deleting group: \(workflowGroup.name)"
            alert.informativeText = "Are you sure you'd like to permanently delete this group?"
            alert.addButton(withTitle: "Delete")
            alert.addButton(withTitle: "Cancel")
            switch alert.runModal() {
            case .alertFirstButtonReturn:
                ()
            case .alertSecondButtonReturn:
                return false
            default:
                return false
            }
        }
        self.workflowGroups.removeAll(where: { $0.id == workflowGroup.id })
        PreferencesController.deleteWorkflowGroup(workflowGroup: workflowGroup)
        return true
    }
    
    /** Replace a group with the provided group, if a group has a matching ID. */
    func replaceGroupById(workflowGroup: WorkflowGroup) {
        if let index = self.workflowGroups.firstIndex(where: { $0.id == workflowGroup.id }) {
            self.workflowGroups[index] = workflowGroup
        }
        PreferencesController.saveWorkflowGroup(workflowGroup: workflowGroup)
    }
}
