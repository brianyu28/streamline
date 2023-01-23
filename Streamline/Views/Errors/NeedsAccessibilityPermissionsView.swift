//
//  NeedsAccessibilityPermissionsView.swift
//  Streamline
//
//  Created by Brian Yu on 1/20/23.
//

import SwiftUI

struct NeedsAccessibilityPermissionsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(AppConstants.appName) requires additional permissions.")
                .font(.title)
                .fontWeight(.bold)
                .padding([.bottom], 10)
            Text("To use \(AppConstants.appName), follow these steps:")
            Text("1. Open System Settings")
            Text("2. Choose \"Privacy and Security\"")
            Text("3. Choose \"Accessibility\"")
            Text("4. Add \(AppConstants.appName) as an application that can control your computer.")
            Text("5. Restart \(AppConstants.appName)")
        }
    }
}

struct NeedsAccessibilityPermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        NeedsAccessibilityPermissionsView()
    }
}
