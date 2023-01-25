//
//  WorkflowView.swift
//  Streamline
//
//  Created by Brian Yu on 1/24/23.
//

import SwiftUI

struct WorkflowView: View {
    @Binding var workflow : Workflow
    
    var body: some View {
        VStack {
            TextField("Name", text: $workflow.name)
        }
    }
}

struct WorkflowView_Previews: PreviewProvider {
    static var previews: some View {
        WorkflowView(workflow: .constant(.previewWorkflow))
    }
}
