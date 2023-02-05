//
//  PossibleGroupView.swift
//  Streamline
//
//  This view exists so that a deleted group (which is no longer selected)
//  doesn't appear in the view anywhere.
//
//  Created by Brian Yu on 2/4/23.
//

import SwiftUI

struct PossibleGroupView: View {
    @Binding var group: WorkflowGroup
    @Binding var selectionId: UUID?
    let resetGroupSelection: () -> Void
    
    var body: some View {
        if selectionId == group.id {
            GroupView(group: $group, resetGroupSelection: resetGroupSelection)
        }
    }
}

struct PossibleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        PossibleGroupView(
            group: .constant(.previewGroup),
            selectionId: .constant(WorkflowGroup.previewGroup.id),
            resetGroupSelection: {}
        )
    }
}
