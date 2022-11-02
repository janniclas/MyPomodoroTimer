//
//  TimerView.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 31.10.22.
//

import SwiftUI

struct TimerView: View {
    
    let name: String
    let timer: CustomTimer
    @State var displayedTime: String
    
    @State var startStop: String = "Start"
    
    init(name: String, startTime: UInt16 = 0) {
        self.name = name
        self.timer = CustomTimer(startTime: startTime)
        self.displayedTime = timer.time
    }
    
    var body: some View {
        VStack {
            Text(name)
            Text(displayedTime)
                .onReceive(self.timer.$time) { newValue in
                    self.displayedTime = newValue
                }
                .font(.system(size: 36, weight: .black, design: .serif))
                .padding()
            Button(self.startStop, action: {
                switch self.timer.state {
                case .stopped:
                    self.timer.start()
                case .running:
                    self.timer.stop()
                case .finished:
                    self.timer.reset()
                }
            }).onReceive(self.timer.$state) { state in
                switch state {
                case .running:
                    self.startStop = "Stop"
                case .stopped:
                    self.startStop = "Start"
                case .finished:
                    self.startStop = "Reset"
                }
            }
        }
        .padding()
        .frame(minWidth: 250, minHeight: 200)
        .background(.ultraThinMaterial)
        .cornerRadius(10)

    }
    
    
}

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

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView( name: "Pomodoro", startTime: 400)
    }
}
