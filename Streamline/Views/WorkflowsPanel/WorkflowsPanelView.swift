//
//  WorkflowsPanelView.swift
//  Streamline
//
//  Created by Brian Yu on 2/3/23.
//

import SwiftUI

struct WorkflowsPanelView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let panel: StreamlinePanel
    let resizeWithResultsCount: (Int) -> Void
    
    @State private var searchText = ""
    @State private var matchingWorkflows: [Workflow] = []
    @State private var selectedIndex = 0
    
    func runWorkflow(workflow: Workflow) {
        panel.close()
        EventHandler.runWorkflow(workflow: workflow, simulateDeletes: false)
    }
    
    func setSelectedIndex(index: Int) {
        selectedIndex = max(min(index, matchingWorkflows.count - 1), 0)
    }
    
    var body: some View {
        VStack {
            TextField("Search Streamline workflows...", text: $searchText)
                .textFieldStyle(.plain)
                .padding(15)
                .background(colorScheme == .dark ? AppConstants.colorQuickPickerFieldDark : AppConstants.colorQuickPickerField)
                .cornerRadius(10)
                .font(.system(size: 18))
                .onChange(of: searchText) { searchText in
                    
                    // Get workflows that match the search text, reverse ordered by score
                    matchingWorkflows = AppState.shared.workflows.map { workflow in
                        (workflow, workflow.getMatchScoreForSearchText(searchText: searchText))
                    }
                    .filter { _, score in score > 0 }
                    .sorted { $0.1 > $1.1 }
                    .map { workflow, _ in workflow }
                    
                    selectedIndex = 0
                    resizeWithResultsCount(matchingWorkflows.count)
                }
                .onSubmit {
                    if matchingWorkflows.indices.contains(selectedIndex) {
                        self.runWorkflow(workflow: matchingWorkflows[selectedIndex])
                    }
                }
            if (matchingWorkflows.count > 0) {
                PanelResultsView(
                    workflows: matchingWorkflows,
                    runWorkflow: runWorkflow,
                    selectedIndex: selectedIndex,
                    setSelectedIndex: setSelectedIndex
                )
            }
        }
        .padding()
        .onAppear {
            NSEvent.addLocalMonitorForEvents(matching: [.keyDown], handler: { event in
                if event.keyCode == 125 { // Down arrow
                    self.setSelectedIndex(index: selectedIndex + 1)
                } else if event.keyCode == 126 { // Up arrow
                    self.setSelectedIndex(index: selectedIndex - 1)
                }
                return event
            })
        }
    }
}

struct WorkflowsPanelView_Previews: PreviewProvider {
    static var previews: some View {
        WorkflowsPanelView(panel: StreamlinePanel(contentRect: NSRect(x: 0, y: 0, width: 512, height: 50), backing: .buffered, defer: false), resizeWithResultsCount: { _ in })
    }
}
