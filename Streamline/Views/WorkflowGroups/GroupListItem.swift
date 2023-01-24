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
    
    /** Function to update name of group. */
    let updateName: (String) -> Void
    
    /** Whether group name is currently being edited. */
    var isEditing: Bool
    
    /** Focus state of the text field, used to auto-focus the edit field when a group is created. */
    @FocusState.Binding var isTextFieldFocused: Bool
    @Binding var groupTextFieldContent: String
    
    var body: some View {
        HStack {
            Image(systemName: "rectangle.stack")
            if isEditing {
                TextField("Name",
                  text: $groupTextFieldContent,
                  onEditingChanged: { editingChanged in
                    if !editingChanged {
                        updateName(groupTextFieldContent)
                    }
                  },
                  onCommit: {
                    updateName(groupTextFieldContent)
                })
                .focused($isTextFieldFocused)
                .padding([.leading], -8)
            } else {
                Text(group.name)
                Spacer()
            }
        }
    }
}

struct GroupListItem_Previews: PreviewProvider {
    @FocusState static var isTextFieldFocused: Bool
    static var previews: some View {
        GroupListItem(
            group: WorkflowGroup(name: "Test Group"),
            updateName: { _ in ()},
            isEditing: true,
            isTextFieldFocused: $isTextFieldFocused,
            groupTextFieldContent: .constant("Test Group")
        )
        .frame(width: 200)
    }
}
