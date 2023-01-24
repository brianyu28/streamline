//
//  GroupsView.swift
//  Streamline
//
//  Created by Brian Yu on 1/22/23.
//

import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var selection: WorkflowGroup? = nil
    
    /** State relating to editing a current group name. */
    @State private var isEditingGroupName: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    @State private var groupTextFieldContent: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Groups View")
            ForEach(appState.workflowGroups) { group in
                GroupListItem(
                    group: group,
                    updateName: { newName in
                        appState.updateGroupName(id: group.id, name: newName)
                        isEditingGroupName = false
                    },
                    isEditing: selection == group && isEditingGroupName,
                    isTextFieldFocused: $isTextFieldFocused,
                    groupTextFieldContent: $groupTextFieldContent
                )
                .padding(10)
                .background(selection == group ? AppConstants.colorGroupsSidebarHighlight : AppConstants.colorGroupsSidebar)
                .cornerRadius(10)
                .onTapGesture {
                    if (selection == group) {
                        // Edit the selected group's name
                        if !isEditingGroupName {
                            groupTextFieldContent = group.name
                            isEditingGroupName = true
                            isTextFieldFocused = true
                        }
                    } else {
                        if let selection = selection, isEditingGroupName {
                            appState.updateGroupName(id: selection.id, name: groupTextFieldContent)
                        }
                        isEditingGroupName = false
                        selection = group
                    }
                }
            }
            
            Button("Create Group") {
                let group = appState.createNewWorkflowGroup()
                selection = group
                groupTextFieldContent = ""
                isEditingGroupName = true
                isTextFieldFocused = true
            }
        }
        .background(AppConstants.colorGroupsSidebar)
        .frame(maxHeight: .infinity)
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
            .environmentObject(AppState.previewState)
    }
}
