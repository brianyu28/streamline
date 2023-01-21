//
//  ContentView.swift
//  Streamline
//
//  Created by Brian Yu on 1/18/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState.shared
    
    var body: some View {
        VStack {
            if appState.appHasAccessibilityPermissions ?? false {
                Text("Streamline is running.")
            } else {
                NeedsAccessibilityPermissionsView()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
