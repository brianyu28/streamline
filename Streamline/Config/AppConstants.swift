//
//  AppConstants.swift
//  Streamline
//
//  Created by Brian Yu on 1/20/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct AppConstants {
    static let appName = "Streamline"
    
    static let colorGroupsSidebar = Color(red: 0.98, green: 0.98, blue: 0.98)
    static let colorGroupsSidebarHighlight = Color(red: 0.86, green: 0.86, blue: 0.86)
    static let colorTextCaption = Color(red: 0.4, green: 0.4, blue: 0.4)
    
    static let streamlineFileType = UTType("me.brianyu.streamline")!
}
