//
//  TimerView.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 31.10.22.
//

import SwiftUI

struct TimerView: View {
    
    private static let defaultStartTime:UInt16 = 1500
    
    let name: String
    let timer: CustomTimer

    @State var displayedTime: String
    @State var startStop: String = "Start"
    
    init(name: String) {
        self.init(name: name, timer: CustomTimer(startTime: TimerView.defaultStartTime))
    }
    
    init(name: String, timer: CustomTimer) {
        self.name = name
        self.timer = timer
        self.displayedTime = self.timer.time
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

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView( name: "Pomodoro")
    }
}
