//
//  StreamlinePanel.swift
//  Streamline
//
//  Created by Brian Yu on 2/3/23.
//
//  Reference: https://cindori.com/developer/floating-panel
//  Reference: https://www.markusbodner.com/til/2021/02/08/create-a-spotlight/alfred-like-window-on-macos-with-swiftui/
//

import SwiftUI

class StreamlinePanel: NSPanel {
    static let panelWidth = 512
    static let panelBaseHeight = 80
    static let panelResultHeight = 100 // 90 for panel result, 10 for padding
    static let maxVisibleResults = 3 // only show 3 results at a time
    
    init(contentRect: NSRect, backing: NSWindow.BackingStoreType, defer flag: Bool) {
        // Creating a panel, "nonactivating" so that Streamline doesn't need to be active to show it
        super.init(contentRect: contentRect, styleMask: [.nonactivatingPanel, .titled, .closable, .fullSizeContentView], backing: backing, defer: flag)
        self.isFloatingPanel = true
        self.level = .floating
        self.collectionBehavior.insert(.fullScreenAuxiliary)
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true
        self.isMovableByWindowBackground = true
        self.isReleasedWhenClosed = false
        self.hidesOnDeactivate = false
        self.animationBehavior = .utilityWindow
        self.standardWindowButton(.closeButton)?.isHidden = true
        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(.zoomButton)?.isHidden = true
    }
    
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
    override func resignMain() {
        super.resignMain()
        close()
    }
    
    func resizeWithResultsCount(count: Int) {
        let count = min(count, Self.maxVisibleResults)
        self.setContentSize(
            NSSize(width: Self.panelWidth, height: Self.panelBaseHeight + count * Self.panelResultHeight)
        )
    }
    
    static func show() {
        let panel = StreamlinePanel(
            contentRect: NSRect(x: 0, y: 0, width: Self.panelWidth, height: Self.panelBaseHeight),
            backing: .buffered,
            defer: false
        )
        panel.minSize = NSSize(width: Self.panelWidth, height: Self.panelBaseHeight)
        
        let view = WorkflowsPanelView(panel: panel, resizeWithResultsCount: { count in
            panel.resizeWithResultsCount(count: count)
        }).ignoresSafeArea()
        
        panel.title = AppConstants.appName
        panel.contentView = NSHostingView(rootView: view)
        panel.center()
        panel.makeKeyAndOrderFront(self)
        panel.orderFrontRegardless()
    }
}
