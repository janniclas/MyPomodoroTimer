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
    private static let defaultTime: UInt16 = 4
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
    @StateObject var timer: CustomTimer = CustomTimer(startTime: MyPomodoroTimerApp.defaultTime)
    
    init() {
        if #unavailable(macOS 13.0) {
            self.showMenuBarExtra = false
        }
    }
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(timer)
        }
        
        
#if os(macOS)
        Settings {
            SettingsView()
        }
        
        MenuBarExtra(
            timer.time,
            isInserted: $showMenuBarExtra) {
                TimerView(name: "Menu Bar")
                    .environmentObject(timer)
                
            }
            .menuBarExtraStyle(.window)
#endif
        
    }
    
}
