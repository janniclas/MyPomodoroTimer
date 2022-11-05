//
//  MyTimer.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 04.11.22.
//

import Foundation
import AudioToolbox

class CustomTimer: ObservableObject {
    
    enum State {
        case running
        case stopped
        case finished
    }
    
    private var startTime: UInt16
    /// Current timer value in seconds
    private var currentTime: UInt16
    private var timer: Timer? = nil

    private var alarmSound: SystemSoundID? = nil
    
    
    @Published var time: String
    @Published var state: State = .stopped

    
    init(startTime: UInt16 = 1500, playAlarm: Bool = true) {
        self.startTime = startTime
        self.currentTime = startTime
        self.time = ""
        self.time = toString()
        if(playAlarm) {
            #if os(macOS)
                alarmSound = SystemSoundID(kSystemSoundID_FlashScreen)
            #endif
            #if os(iOS)
                alarmSound = SystemSoundID(kSystemSoundID_Vibrate)
            #endif

        }
    }
    
    /// Takes a timer value in seconds and transforms it into String representation
    /// Return format: "MM:SS"
    private func toString() -> String {
        
        if self.currentTime == 0 {
            return "00:00" //TODO: maybe we want a custom finished message?
        }
        
        let minutes = self.currentTime / 60
        let seconds = self.currentTime % 60
        
        func applyPadding(number: UInt16) -> String {
            let sNumber = String(number)
            if (number < 10) {
                return "0\(sNumber)"
            }
            return sNumber
        }
        return String("\(applyPadding(number: minutes)):\(applyPadding(number: seconds))")
    }
    
    /// Works depending on the internal state of the timer
    /// state == .stopped --> starts timer
    /// state == .running --> stops timer
    /// state == .finished --> resets timer
    func toggle() {
        switch self.state {
        case .stopped:
            self.start()
        case .running:
            self.stop()
        case .finished:
            self.reset()
        }
    }
    
    private func start() {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            if(self.currentTime == 0) {
                if let alarmId = self.alarmSound {
                    AudioServicesPlayAlertSound(alarmId)
                }
                self.stop(newState: .finished)
                // TODO: finished
            } else {
                self.currentTime -= 1
                self.time = self.toString()
            }
        }
        self.state = .running
    }
    
    private func stop(newState: State = .stopped) {
        self.timer?.invalidate()
        self.timer = nil
        self.state = newState
    }
    
    private func reset() {
        self.stop()
        self.currentTime = startTime
        self.time = toString()
    }
}
