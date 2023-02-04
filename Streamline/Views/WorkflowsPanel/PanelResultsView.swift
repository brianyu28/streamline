//
//  PanelResultsView.swift
//  Streamline
//
//  Created by Brian Yu on 2/4/23.
//

import SwiftUI

struct PanelResultsView: View {
    let workflows: [Workflow]
    let runWorkflow: (Workflow) -> Void
    let selectedIndex: Int
    let setSelectedIndex: (Int) -> Void
    
    var body: some View {
        ScrollViewReader { scrollValue in
            ScrollView {
                VStack {
                    ForEach(Array(workflows.enumerated()), id: \.element) { index, workflow in
                        PanelResultView(workflow: workflow, isSelected: index == selectedIndex)
                            .onHover { hover in
                                if hover {
                                    setSelectedIndex(index)
                                }
                            }
                            .onTapGesture {
                                runWorkflow(workflow)
                            }
                            .id(index)
                    }
                }
            }
            .onChange(of: selectedIndex) { selectedIndex in
                scrollValue.scrollTo(selectedIndex)
            }
        }
    }
}

struct PanelResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PanelResultsView(
            workflows: [],
            runWorkflow: { _ in },
            selectedIndex: 0,
            setSelectedIndex: { _ in }
        )
    }
}
