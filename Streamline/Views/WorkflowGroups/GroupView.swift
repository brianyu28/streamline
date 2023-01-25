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
    
    var body: some View {
        VSplitView {
            VStack {
                Button("Add") {
                    let workflow = Workflow(
                        name: "Test",
                        trigger: ":test",
                        content: "Test Content"
                    )
                    group.workflows.append(workflow)
                    selectedWorkflow = workflow.id
                }
                Table(group.workflows, selection: $selectedWorkflow) {
                    TableColumn("Name", value: \.name)
                    TableColumn("Trigger", value: \.trigger)
                    TableColumn("Content", value: \.content)
                }
            }
            .padding([.top])
            .frame(maxHeight: .infinity)
            
            if let workflow = group.workflows.first(where: {$0.id == selectedWorkflow}) {
                Text("Detail View: \(workflow.name)")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text("Select a workflow to view details.")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
        }
        .navigationTitle(group.name)
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(group: .constant(.previewGroup))
    }
}
