//
//  DebugView.swift
//  Streamline
//
//  Created by Brian Yu on 2/8/23.
//

import SwiftUI

struct DebugView: View {
    @StateObject var appState = AppState.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Debug Mode")
                    .fontWeight(.bold)
                Text("Has accessibility permissions? \(appState.appHasAccessibilityPermissions ?? false ? "Yes" : "No")")
                Text("Workflow group count: \(appState.workflowGroups.count)")
                Text("Workflow count: \(appState.workflowGroups.map({ $0.workflows.count }).reduce(0, +))")
                Text("Cached workflow group keys: \(appState.cachedWorkflowMap.count)")
                Text("Cached workflow count: \(appState.cachedWorkflowMap.map({ $0.value.count }).reduce(0, +))")
            }
            Divider()
            Text("Current Input Buffer:")
            TextField("Input Buffer", text: .constant(appState.monitoredInput))
            Spacer()
            Text("This application is currently in debug mode. To exit this mode, go to the Help menu and choose Exit Debug Mode.")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
