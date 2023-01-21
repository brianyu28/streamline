//
//  AppState.swift
//  Streamline
//
//  Created by Brian Yu on 1/20/23.
//

import SwiftUI

class AppState: ObservableObject {
    static let shared = AppState()
    
    /** Whether the app has accessibility access. */
    @Published var appHasAccessibilityPermissions : Bool? = nil
    
    /** Whether the app is currently executing a workflow. */
    @Published var isCurrentlyExecutingWorkflow = false
    
    /** The currently typed string by the user, for matching typed text triggers. */
    @Published var monitoredInput: String = ""
    
    /** Workflows to actively listen for. */
    // TODO: Let user configure these. For testing for now, using a predefined list of workflows.
    @Published var workflows: [Workflow] = [
        Workflow(trigger: ":test1", content: "Expanded  1"),
        Workflow(trigger: ":test2", content: "Expanded 2"),
        Workflow(trigger: ":testing2", content: "Expanded 3"),
    ]
}
