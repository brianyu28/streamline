//
//  WorkflowGroupsState.swift
//  Streamline
//
//  Created by Brian Yu on 1/22/23.
//

import Foundation

extension AppState {
    func createNewWorkflowGroup() -> WorkflowGroup {
        let workflowGroup = WorkflowGroup()
        self.workflowGroups.append(workflowGroup)
        return workflowGroup
    }
}
