//
//  WorkflowGroup.swift
//  Streamline
//
//  Created by Brian Yu on 1/22/23.
//

import Foundation

struct WorkflowGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var name : String = ""
    var workflows: [Workflow] = []
}

extension WorkflowGroup {
    mutating func deleteWorkflowById(workflowId: UUID) {
        self.workflows.removeAll(where: { $0.id == workflowId })
    }
    
    // Regenerate all IDs for group and workflows.
    mutating func regenerateIds() {
        self.id = UUID()
        for (i, _) in workflows.enumerated() {
            self.workflows[i].id = UUID()
        }
    }
}

extension WorkflowGroup: Equatable {
    static func == (lhs: WorkflowGroup, rhs: WorkflowGroup) -> Bool {
        lhs.id == rhs.id
    }
}

// Serialization
extension WorkflowGroup {
    func serialize() -> String? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            let json = String(data: data, encoding: String.Encoding.utf8)
            return json
        } catch {
            return nil
        }
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
