//
//  GroupsView.swift
//  Streamline
//
//  Created by Brian Yu on 1/22/23.
//

import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var selectionId: UUID? = nil
    @State private var isEditingSelectionName: Bool = false
    @State private var editedSelectionName: String = ""
    @FocusState private var focusedTextEditor: UUID?

    /** Start editing the title of a workflow group. */
    func startEditingGroup(group: WorkflowGroup) {
        selectionId = group.id
        editedSelectionName = group.name
        isEditingSelectionName = true
        focusedTextEditor = group.id
    }
    
    var body: some View {
        NavigationView {
            List {
                Text("Workflow Groups")
                    .fontWeight(.bold)
                ForEach($appState.workflowGroups) { $group in
                    NavigationLink(
                        destination: GroupView(group: $group),
                        tag: group.id,
                        selection: $selectionId
                    ) {
                        TextField("Group Name", text: $group.name)
                            .focused($focusedTextEditor, equals: group.id)
                    }
                }
            }
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu("\(Image(systemName: "plus"))") {
                        Button("New Workflow Group") {
                            let group = appState.createNewWorkflowGroup()
                            self.startEditingGroup(group: group)
                        }
                    }
                }
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
