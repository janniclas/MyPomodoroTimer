//
//  SettingsView.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 01.11.22.
//

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, advanced
    }
    var body: some View {
        HStack {
            Text("Welcome to the settings")
            // Timer setting
            // image selection
            // break settings
        }
        .padding(20)
        .frame(width: 375, height: 150)
    }
}
