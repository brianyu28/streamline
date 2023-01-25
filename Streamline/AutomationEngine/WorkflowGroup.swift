//
//  WorkflowGroup.swift
//  Streamline
//
//  Created by Brian Yu on 1/22/23.
//

import Foundation

struct WorkflowGroup: Identifiable, Hashable {
    var id = UUID()
    var name : String = ""
    var workflows: [Workflow] = []
}

extension WorkflowGroup: Equatable {
    static func == (lhs: WorkflowGroup, rhs: WorkflowGroup) -> Bool {
        lhs.id == rhs.id
    }
}

// Preview
extension WorkflowGroup {
    static let previewGroup : WorkflowGroup = WorkflowGroup(
        id: UUID(),
        name: "Example Group",
        workflows: [
            Workflow(name: "Trigger 1", trigger: ":test1", content: "Expanded  1"),
            Workflow(name: "Trigger 2", trigger: ":test2", content: "Expanded 2"),
            Workflow(name: "Trigger 3", trigger: ":testing2", content: "Expanded 3"),
        ]
    )
}
