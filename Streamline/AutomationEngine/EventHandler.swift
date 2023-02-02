//
//  EventListener.swift
//  Streamline
//
//  Created by Brian Yu on 1/20/23.
//

import Cocoa

struct EventHandler {
    
    /** Characters are tracked when typed without modifier flags or typed with Shift. */
    static let allowableCharacterModifierFlags = [256, 131330]
    
    /** Some key codes should reset the currently monitored string: e.g. arrow keys, enter, return */
    static let resettingKeyCodes = [123, 124, 125, 126, 76, 36]
    static let backspaceKeyCodes = [51]
    
    /** All system events to listen for. */
    static let eventsToMonitor: NSEvent.EventTypeMask = [.keyDown, .leftMouseDown, .rightMouseDown, .otherMouseDown]
    
    /** Check if Streamline has accessibilty access, requesting it if needed. */
    static func checkEventListeningPermissions() -> Bool {
        let prompt: String = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String
        let options: NSDictionary = [prompt: true]
        let appHasAccessibilityPermissions: Bool = AXIsProcessTrustedWithOptions(options)
        AppState.shared.appHasAccessibilityPermissions = appHasAccessibilityPermissions
        return appHasAccessibilityPermissions
    }
    
    static func startListeningForSystemEvents() {
        NSEvent.addGlobalMonitorForEvents(matching: self.eventsToMonitor, handler: handleEvent)
    }
    
    static func handleEvent(event: NSEvent) {
        // Don't handle any events triggered during a workflow run
        if AppState.shared.isCurrentlyExecutingWorkflow {
            return
        }
        
        switch (event.type) {
            
        // TODO: Doesn't handle special characters that require modifier keys other than Shift pressed. Need some way to detect typing events vs. shortcuts.
        case NSEvent.EventType.keyDown:
            if Self.resettingKeyCodes.contains(Int(event.keyCode)) {
                AppState.shared.monitoredInput = ""
                return
            }
            if Self.backspaceKeyCodes.contains(Int(event.keyCode)) {
                if AppState.shared.monitoredInput.count > 0 {
                    AppState.shared.monitoredInput = String(AppState.shared.monitoredInput.dropLast())
                }
                return
            }
            if Self.allowableCharacterModifierFlags.contains(Int(event.modifierFlags.rawValue)) {
                AppState.shared.monitoredInput += event.characters ?? ""
            } else {
                AppState.shared.monitoredInput = ""
                return
            }
        default:
            // When an event is triggered other than key down, reset the monitored input.
            AppState.shared.monitoredInput = ""
            return
        }
//        print("Monitored Input: \(AppState.shared.monitoredInput)")
        
        if let workflow = Workflow.findWorkflowMatchingInput(
            input: AppState.shared.monitoredInput,
            workflows: AppState.shared.workflows) {
            AppState.shared.isCurrentlyExecutingWorkflow = true
            Self.copyToClipboard(content: workflow.content)
            Self.simulateDeletes(count: workflow.trigger.count)
            Self.triggerPasteKeyboardShortcut()
            AppState.shared.isCurrentlyExecutingWorkflow = false
        }
    }
    
    static func copyToClipboard(content: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.writeObjects([content as NSString])
    }
    
    static func simulateDeletes(count: Int) {
        let delDownEvent = CGEvent.init(keyboardEventSource: nil, virtualKey: 51, keyDown: true)
        let delUpEvent = CGEvent.init(keyboardEventSource: nil, virtualKey: 51, keyDown: false)
        for _ in 1...count {
            delDownEvent?.post(tap: .cghidEventTap)
            delUpEvent?.post(tap: .cghidEventTap)
        }
    }
    
    static func triggerPasteKeyboardShortcut() {
        let cmdDownEvent = CGEvent.init(keyboardEventSource: nil, virtualKey: 56, keyDown: true)
        let keyDownEvent = CGEvent.init(keyboardEventSource: nil, virtualKey: 9, keyDown: true)
        let keyUpEvent = CGEvent.init(keyboardEventSource: nil, virtualKey: 9, keyDown: false)
        let cmdUpEvent = CGEvent.init(keyboardEventSource: nil, virtualKey: 56, keyDown: false)
        
        cmdDownEvent?.flags = [.maskCommand]
        keyDownEvent?.flags = [.maskCommand]
        keyUpEvent?.flags = [.maskCommand]
        cmdUpEvent?.flags = [.maskCommand]
        
        cmdDownEvent?.post(tap: .cghidEventTap)
        keyDownEvent?.post(tap: .cghidEventTap)
        keyUpEvent?.post(tap: .cghidEventTap)
        cmdUpEvent?.post(tap: .cghidEventTap)
    }
}
