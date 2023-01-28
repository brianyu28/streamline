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
    
    let workflowGroup: WorkflowGroup
    
    var body: some View {
        VStack {
            HStack {
                Text("Name")
                    .frame(width: 80, alignment: .trailing)
                Spacer()
                TextField("", text: Binding(
                    get: { workflow.name },
                    set: {
                        if (workflow.name == $0) {
                            return
                        }
                        workflow.name = $0
                        appState.scheduleSaveWorkflowGroup(workflowGroup: workflowGroup)
                    }
                ))
                .focused(nameFieldFocused)
            }
            HStack {
                Text("Trigger")
                    .frame(width: 80, alignment: .trailing)
                Spacer()
                TextField("", text: Binding(
                    get: { workflow.trigger },
                    set: {
                        if (workflow.trigger == $0) {
                            return
                        }
                        workflow.trigger = $0
                        appState.scheduleSaveWorkflowGroup(workflowGroup: workflowGroup)
                    }
                ))
            }
            Divider()
            VStack(alignment: .leading) {
                Text("Content")
                    .padding([.leading])
                TextEditor(text: Binding(
                    get: { workflow.content },
                    set: {
                        if (workflow.content == $0) {
                            return
                        }
                        workflow.content = $0
                        appState.scheduleSaveWorkflowGroup(workflowGroup: workflowGroup)
                    }
                ))
                .padding([.leading, .trailing])
                .font(.custom("HelveticaNeue", size: 13))
            }
        }
    }
}

struct WorkflowView_Previews: PreviewProvider {
    @FocusState static var nameFieldFocused : Bool
    
    static var previews: some View {
        WorkflowView(
            workflow: .constant(.previewWorkflow),
            nameFieldFocused: $nameFieldFocused,
            workflowGroup: .previewGroup
        )
    }
}
