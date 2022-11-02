//
//  MyPomodoroTimerApp.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 31.10.22.
//

import SwiftUI

@main
struct MyPomodoroTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}


// TODO:
// menu bar extras
// -- popovers
