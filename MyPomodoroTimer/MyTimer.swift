//
//  MyTimer.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 04.11.22.
//

import Foundation


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
    @Published var time: String
    @Published var state: State = .stopped
    
    init(startTime: UInt16) {
        self.startTime = startTime
        self.currentTime = startTime
        self.time = ""
        self.time = toString()
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
    
    func start() {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            if(self.currentTime == 0) {
                self.stop(newState: .finished)
                // TODO: finished
            } else {
                self.currentTime -= 1
                self.time = self.toString()
            }
        }
        self.state = .running
    }
    
    func stop(newState: State = .stopped) {
        self.timer?.invalidate()
        self.timer = nil
        self.state = newState
    }
    
    func reset() {
        self.stop()
        self.currentTime = startTime
        self.time = toString()
    }
}
