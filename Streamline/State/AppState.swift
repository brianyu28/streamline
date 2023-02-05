//
//  AppState.swift
//  Streamline
//
//  Created by Brian Yu on 1/20/23.
//

import KeyboardShortcuts
import SwiftUI

class AppState: ObservableObject {
    static let shared = AppState()
    
    /** Whether the app has accessibility access. */
    @Published var appHasAccessibilityPermissions : Bool? = nil
    
    /** Whether the app is currently executing a workflow. */
    @Published var isCurrentlyExecutingWorkflow = false
    
    /** The currently typed string by the user, for matching typed text triggers. */
    @Published var monitoredInput: String = ""
    
    @Published var workflowGroups: [WorkflowGroup] = []
    
    init() {
        KeyboardShortcuts.onKeyUp(for: .toggleStreamlinePanel) {
            StreamlinePanel.show()
        }
    }
    
    /** Mapping of workflow group IDs to the time of the next save of the workflow group. */
    var workflowGroupSaveTimes: [UUID: DispatchTime] = [:]
    
    var workflows: [Workflow] {
        var results: [Workflow] = []
        for group in self.workflowGroups {
            if !group.isEnabled {
                continue
            }
            for workflow in group.workflows {
                results.append(workflow)
            }
        }
        return results
    }
}

// Preview state
extension AppState {
    static var previewState : AppState {
        let state = AppState()
        state.appHasAccessibilityPermissions = true
        state.workflowGroups = [
            WorkflowGroup(name: "Example Group 1"),
            WorkflowGroup(name: "Example Group 2"),
        ]
        return state
    }
}
