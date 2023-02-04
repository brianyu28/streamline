//
//  AppConstants.swift
//  Streamline
//
//  Created by Brian Yu on 1/20/23.
//

import KeyboardShortcuts
import SwiftUI
import UniformTypeIdentifiers

struct AppConstants {
    static let appName = "Streamline"
    
    static let colorQuickPickerField = Color(red: 0.9, green: 0.9, blue: 0.9)
    static let colorQuickPickerSelected = Color(red: 84 / 255, green: 167 / 255, blue: 255 / 255)
    static let colorTextCaption = Color(red: 0.4, green: 0.4, blue: 0.4)
    
    static let streamlineFileType = UTType("me.brianyu.streamline")!
}

extension KeyboardShortcuts.Name {
    static let toggleStreamlinePanel = Self("toggleStreamlinePanel", default: .init(.space, modifiers: [.option]))
}
