//
//  GroupView.swift
//  Streamline
//
//  Created by Brian Yu on 1/24/23.
//

import SwiftUI

struct GroupView: View {
    @Binding var group: WorkflowGroup
    
    /** Workflow currently selected in table. */
    @State private var selectedWorkflow: Workflow.ID? = nil
    
    /** If workflow was just created, it takes precedence over the table selection. */
    @State private var createdWorkflow: Workflow.ID? = nil
    
    /** Whether we should focus the name text field for the workflow, such as when a new workflow is created.  */
    @FocusState private var workflowNameFocused: Bool
    
    /** Gets the selected workflow, or the newly created workflow if it exists. */
    func getSelectedWorkflow() -> Binding<Workflow>? {
        if let createdWorkflow = createdWorkflow {
            return $group.workflows.first(where: {$0.id == createdWorkflow})
        } else if let selectedWorkflow = selectedWorkflow {
            return $group.workflows.first(where: {$0.id == selectedWorkflow})
        } else {
            return nil
        }
    }
    
    var body: some View {
            VStack {
                Table(group.workflows, selection: $selectedWorkflow) {
                    TableColumn("Name", value: \.name)
                    TableColumn("Trigger", value: \.trigger)
                    TableColumn("Content", value: \.content)
                }
                .onChange(of: selectedWorkflow) { _ in
                    if selectedWorkflow != nil {
                        createdWorkflow = nil
                    }
                }
                
                VStack {
                    if let $workflow = getSelectedWorkflow() {
                        WorkflowView(
                            workflow: $workflow,
                            nameFieldFocused: $workflowNameFocused
                        )
                    } else {
                        Text("Select a workflow to view details.")
                    }
                }
                .frame(minHeight: 200)
                .padding()
            }
            .padding([.top])
            .navigationTitle(group.name)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button() {
                        let workflow = Workflow(
                            name: "",
                            trigger: "",
                            content: ""
                        )
                        group.workflows.append(workflow)
                        createdWorkflow = workflow.id
                        selectedWorkflow = nil
                        DispatchQueue.main.async {
                            workflowNameFocused = true
                        }
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                    .help("Add a new workflow")
                }
            }
        }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(group: .constant(.previewGroup))
    }
}
