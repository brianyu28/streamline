//
//  WorkflowGroupsState.swift
//  Streamline
//
//  Created by Brian Yu on 1/22/23.
//

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
    func deleteGroup(workflowGroup: WorkflowGroup) {
        self.workflowGroups.removeAll(where: { $0.id == workflowGroup.id })
        PreferencesController.deleteWorkflowGroup(workflowGroup: workflowGroup)
    }
    
    /** Replace a group with the provided group, if a group has a matching ID. */
    func replaceGroupById(workflowGroup: WorkflowGroup) {
        if let index = self.workflowGroups.firstIndex(where: { $0.id == workflowGroup.id }) {
            self.workflowGroups[index] = workflowGroup
        }
        PreferencesController.saveWorkflowGroup(workflowGroup: workflowGroup)
    }
}
