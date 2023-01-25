//
//  Workflow.swift
//  Streamline
//
//  Created by Brian Yu on 1/20/23.
//

import Foundation

/** A workflow represents an automation created by a user. */
/** Currently, workflows can only be used as simple text replacements, but different types of workflows are planned. */
struct Workflow: Hashable {
    var name = ""
    var trigger = ""
    var content = ""
}

extension Workflow {
    /** Return the first workflow whose trigger matches the input. */
    // TODO: Make this more efficient, don't linearly serach on every key press.
    static func findWorkflowMatchingInput(input: String, workflows: [Workflow]) -> Workflow? {
        for workflow in workflows {
            if input.hasSuffix(workflow.trigger) {
                return workflow
            }
        }
        return nil
    }
}

// Previews
extension Workflow {
    static let previewWorkflow : Workflow = Workflow(name: "Test 1", trigger: ":test1", content: "Expanded Test 1")
}
