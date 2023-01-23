//
//  WorkflowGroup.swift
//  Streamline
//
//  Created by Brian Yu on 1/22/23.
//

import Foundation

struct WorkflowGroup: Identifiable {
    var id = UUID()
    var name : String = ""
    var workflows: [Workflow] = []
}

extension WorkflowGroup: Equatable {
    static func == (lhs: WorkflowGroup, rhs: WorkflowGroup) -> Bool {
        lhs.id == rhs.id
    }
}
