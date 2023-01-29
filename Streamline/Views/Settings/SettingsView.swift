//
//  SettingsView.swift
//  Streamline
//
//  Created by Brian Yu on 1/28/23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("shouldHideAppIconFromDock") private var shouldHideAppIconFromDock = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Toggle(isOn: $shouldHideAppIconFromDock) {
                    Text("Hide app icon from Dock (requires restart)")
                }
                Spacer()
            }
            Text("When app icon is hidden from Dock, relaunch application in Finder to open the editor.")
                .font(.callout)
                .foregroundColor(AppConstants.colorTextCaption)
        }
        .padding()
        .frame(minWidth: 400, minHeight: 250)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
