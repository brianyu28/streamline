//
//  GroupsView.swift
//  Streamline
//
//  Created by Brian Yu on 1/22/23.
//

import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var appState: AppState
    
    /** Possible group whose name is currently being edited. */
    @State var groupCurrentlyEditing: WorkflowGroup? = nil
    
    var body: some View {
        VStack {
            Text("Groups View")
            List(appState.workflowGroups) { group in
                GroupListItem(
                    group: group,
                    isEditing: group == groupCurrentlyEditing
                )
            }
            Button("Create Group") {
                print("Creating group...")
                let group = appState.createNewWorkflowGroup()
                groupCurrentlyEditing = group
            }
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
            .environmentObject(AppState.previewState)
    }
}
