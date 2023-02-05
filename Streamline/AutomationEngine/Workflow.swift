//
//  Workflow.swift
//  Streamline
//
//  Created by Brian Yu on 1/20/23.
//

import Foundation

/** A workflow represents an automation created by a user. */
/** Currently, workflows can only be used as simple text replacements, but different types of workflows are planned. */
struct Workflow: Hashable, Identifiable, Codable {
    var id = UUID()
    var name = ""
    var trigger = ""
    var content = ""
}

extension Workflow {
    /** Return the first workflow whose trigger matches the input. */
    static func findWorkflowMatchingInput(input: String, workflows: [Workflow]) -> Workflow? {
        for workflow in workflows {
            if workflow.trigger.count > 0 && input.hasSuffix(workflow.trigger) {
                return workflow
            }
        }
        return nil
    }
    
    /** Get a score for how good of a match the serach text is for the given workflow.
     Scores are higher for a greater proportion of the name, trigger, or content matched.
     Scores where the search text doesn't appear get a score of 0.
     */
    func getMatchScoreForSearchText(searchText: String) -> Double {
        var score : Double = 0
        let searchText = searchText.lowercased()
        let fields = [self.name, self.trigger, self.content]
        for field in fields {
            if !field.isEmpty && field.lowercased().contains(searchText) {
                score += Double(searchText.count) / Double(field.count)
            }
        }
        return score
    }
}

// Previews
extension Workflow {
    static let previewWorkflow : Workflow = Workflow(name: "Test 1", trigger: ":test1", content: "Expanded Test 1")
    static let previewLongWorkflow : Workflow = Workflow(
        name: "This is an example of a long workflow name. This is a continuation of the long workflow name.",
        trigger: ":test-trigger-long",
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec molestie congue lorem, a tristique est. Ut eleifend, ipsum malesuada vulputate rhoncus, nisl urna bibendum est, a cursus quam urna quis lacus. Ut ut dictum est, vitae rhoncus sapien. Proin sit amet volutpat dui, nec pellentesque mi."
    )
}
