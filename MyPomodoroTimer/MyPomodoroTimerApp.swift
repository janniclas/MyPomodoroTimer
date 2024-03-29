//
//  MyPomodoroTimerApp.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 31.10.22.
//

import SwiftUI


@main
@available(macOS 13.0, *)
struct MyPomodoroTimerApp: App {
    private static let defaultPomodoroTime: UInt16 = 4
    private static let defaultBreakTime: UInt16 = 5
    
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
    @StateObject var timer: CustomTimer = CustomTimer(startTime: MyPomodoroTimerApp.defaultPomodoroTime, breakTime: MyPomodoroTimerApp.defaultBreakTime)
#if os(macOS)
    @Environment(\.openWindow) private var openWindow
#endif
    init() {
        if #unavailable(macOS 13.0) {
            self.showMenuBarExtra = false
        }
    }
    
    var body: some Scene {
        
        Window("Just do the Work", id: "timerWindow") {
            ContentView()
                .environmentObject(timer)
        }
#if os(macOS)
        .windowStyle(HiddenTitleBarWindowStyle())
#endif
        
#if os(macOS)
        Window("Take a Break", id: "breakWindow") {
            TakeABreakView()
                .environmentObject(timer)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        
        
        Settings {
            SettingsView()
        }
        
        MenuBarExtra(
            timer.time,
            isInserted: $showMenuBarExtra) {
                TimerView(name: "Menu Bar")
                    .environmentObject(timer)
            }
            .onChange(of: timer.state) { newState in
                if(newState == .finished) {
                    self.openWindow(id: "breakWindow") //TODO: use fullScreenCover to achieve this on iOS
                }
            }
            .menuBarExtraStyle(.window)
#endif
        
    }
    
}
