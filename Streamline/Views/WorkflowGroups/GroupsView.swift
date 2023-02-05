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
    
    func resetGroupSelection() {
        selectionId = nil
    }
    
    var body: some View {
        NavigationView {
            List {
                Text("Groups")
                    .fontWeight(.bold)
                ForEach($appState.workflowGroups) { $group in
                    NavigationLink(
                        destination: PossibleGroupView(group: $group, selectionId: $selectionId, resetGroupSelection: resetGroupSelection),
                        tag: group.id,
                        selection: $selectionId
                    ) {
                        TextField("Group Name", text: Binding(
                            get: { group.name },
                            set: {
                                if (group.name == $0) {
                                    return
                                }
                                group.name = $0
                                appState.scheduleSaveWorkflowGroup(workflowGroup: group)
                            }
                        ))
                            .focused($focusedTextEditor, equals: group.id)
                    }
                    .contextMenu {
                        Button("Export Group") {
                            GroupExportImport.exportWorkflowGroup(workflowGroup: group)
                        }
                        Button("Delete Group") {
                            if appState.deleteGroup(workflowGroup: group, withConfirmation: true) {
                                resetGroupSelection()
                            }
                        }
                    }
                    
                }
            }
            .listStyle(.sidebar)
            .frame(minWidth: 160)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu("\(Image(systemName: "plus"))") {
                        Button("New Group") {
                            let group = appState.createNewWorkflowGroup()
                            self.startEditingGroup(group: group)
                        }
                        Button("Import Group") {
                            GroupExportImport.chooseAndImportWorkflowGroup()
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
