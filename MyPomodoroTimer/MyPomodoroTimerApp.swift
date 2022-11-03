//
//  MyPomodoroTimerApp.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 31.10.22.
//

import SwiftUI

@available(macOS 13.0, *)
@main
struct MyPomodoroTimerApp: App {
    
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
    @State private var icon = "10:00"
    init() {
        if #unavailable(macOS 13.0) {
            self.showMenuBarExtra = false
        }
    }
    var body: some Scene {

        WindowGroup {
            ContentView()
        }
#if os(macOS)
        Settings {
            SettingsView()
        }

            MenuBarExtra(
                icon,
                isInserted: $showMenuBarExtra) {
                    let t = TimerView(name: "Menu Bar", startTime: 600)
                        t
                        .onReceive(t.timer.$time) { newValue in
                            self.icon = newValue
                        }
                }
                .menuBarExtraStyle(.window)
 
#endif
    }
}
