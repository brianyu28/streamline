//
//  GroupView.swift
//  Streamline
//
//  Created by Brian Yu on 1/24/23.
//

import SwiftUI

struct GroupView: View {
    @Binding var group: WorkflowGroup
    
    var body: some View {
        VStack {
            Text(group.name)
        }
        .navigationTitle(group.name)
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(group: .constant(.previewGroup))
    }
}
