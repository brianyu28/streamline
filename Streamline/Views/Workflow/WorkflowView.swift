//
//  WorkflowView.swift
//  Streamline
//
//  Created by Brian Yu on 1/24/23.
//

import SwiftUI

struct WorkflowView: View {
    @EnvironmentObject var appState: AppState
    @Binding var workflow : Workflow
    var nameFieldFocused : FocusState<Bool>.Binding
    
    @Binding var workflowGroup: WorkflowGroup
    
    func scheduleSaveGroup() {
        appState.scheduleSaveWorkflowGroup(workflowGroup: workflowGroup)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Name")
                    .frame(width: 80, alignment: .trailing)
                Spacer()
                TextField("", text: $workflow.name)
                .focused(nameFieldFocused)
            }
            HStack {
                Text("Trigger")
                    .frame(width: 80, alignment: .trailing)
                Spacer()
                TextField("", text: $workflow.trigger)
            }
            Divider()
            VStack(alignment: .leading) {
                Text("Content")
                    .padding([.leading])
                TextEditor(text: $workflow.content)
                .padding([.leading, .trailing])
                .font(.custom("HelveticaNeue", size: 13))
            }
        }
        .onChange(of: workflow.name) { _ in scheduleSaveGroup() }
        .onChange(of: workflow.trigger) { _ in scheduleSaveGroup() }
        .onChange(of: workflow.content) { _ in scheduleSaveGroup() }
    }
}

struct WorkflowView_Previews: PreviewProvider {
    @FocusState static var nameFieldFocused : Bool
    
    static var previews: some View {
        WorkflowView(
            workflow: .constant(.previewWorkflow),
            nameFieldFocused: $nameFieldFocused,
            workflowGroup: .constant(.previewGroup)
        )
    }
}
