//
//  PossibleGroupView.swift
//  Streamline
//
//  This view exists so that a deleted group (which is no longer selected)
//  doesn't appear in the view anywhere.
//
//  Created by Brian Yu on 2/4/23.
//
import SwiftUI

struct PossibleGroupView: View {
    @EnvironmentObject var appState: AppState
    @Binding var group: WorkflowGroup
    
    var body: some View {
        if appState.workflowGroups.contains(where: { $0.id == group.id }) {
            GroupView(group: $group)
        } else {
            EmptyView()
        }
    }
}

struct PossibleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        PossibleGroupView(
            group: .constant(.previewGroup)
        )
        .environmentObject(AppState.previewState)
    }
}
