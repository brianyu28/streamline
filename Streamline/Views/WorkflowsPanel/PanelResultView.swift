//
//  PanelResultView.swift
//  Streamline
//
//  Created by Brian Yu on 2/4/23.
//

import SwiftUI

struct PanelResultView: View {
    let workflow: Workflow
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(workflow.name)
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                Spacer()
                Text(workflow.trigger)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .background(AppConstants.colorQuickPickerField)
                    .cornerRadius(10)
            }
            Text(workflow.content)
                .frame(height: 40, alignment: .top)
        }
        .padding(10)
        .frame(height: 90)
        .background(isSelected ? AppConstants.colorQuickPickerSelected : nil)
        .cornerRadius(10)
    }
}

struct PanelResultView_Previews: PreviewProvider {
    static var previews: some View {
        PanelResultView(workflow: .previewLongWorkflow, isSelected: false)
    }
}
