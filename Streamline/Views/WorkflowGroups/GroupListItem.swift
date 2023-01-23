//
//  GroupListItem.swift
//  Streamline
//
//  Created by Brian Yu on 1/22/23.
//

import SwiftUI

struct GroupListItem: View {
    /** Group represented by this list item. */
    let group: WorkflowGroup
    
    /** Whether group name is currently being edited. */
    let isEditing: Bool
    
    /** Group name that appears in text field. */
    // TODO: This should start as the group's original name.
    @State var editableName = ""
    
    var body: some View {
        HStack {
            Image(systemName: "rectangle.stack")
            if isEditing {
                TextField("Name", text: $editableName)
                    .onSubmit {
                        // TODO: Mark text field as complete.
                    }
            } else {
                Text(group.name)
            }
        }
    }
}

struct GroupListItem_Previews: PreviewProvider {
    static var previews: some View {
        GroupListItem(
            group: WorkflowGroup(name: "Test Group"),
            isEditing: true
        )
    }
}
