//
//  StatePersistence.swift
//  Streamline
//
//  Created by Brian Yu on 1/28/23.
//

import Foundation

extension AppState {
    /** Schedule a save to disk for the workflow group. */
    func scheduleSaveWorkflowGroup(workflowGroup: WorkflowGroup) {
        // Schedule saves to happen after 1.5 seconds, in order to batch changes that happen in close succession.
        let deadline = DispatchTime.now() + 1.5
        self.workflowGroupSaveTimes[workflowGroup.id] = deadline
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            guard let scheduledSaveTime = self.workflowGroupSaveTimes[workflowGroup.id] else {
                return
            }
            if DispatchTime.now() > scheduledSaveTime {
                PreferencesController.saveWorkflowGroup(workflowGroup: workflowGroup)
            }
        }
    }
}
