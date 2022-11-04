//
//  TimerView.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 31.10.22.
//

import SwiftUI

struct TimerView: View {
    
    let name: String
    @EnvironmentObject var timer: CustomTimer
    
    init(name: String) {
        self.name = name
    }
    
    private func getButtonString() -> String {
        switch self.timer.state {
        case .stopped:
            return "Start"
        case .running:
            return "Stop"
        case .finished:
            return "Restart"
        }
    }
    
    var body: some View {
        VStack {
            Text(name)
            Text(timer.time)
                .font(.system(size: 36, weight: .black, design: .serif))
                .padding()
            Button(self.getButtonString(), action: {
                switch self.timer.state {
                case .stopped:
                    self.timer.start()
                case .running:
                    self.timer.stop()
                case .finished:
                    self.timer.reset()
                }
            })
//            .onReceive(self.timer.$state) { state in
//                switch state {
//                case .running:
//                    self.startStop = "Stop"
//                case .stopped:
//                    self.startStop = "Start"
//                case .finished:
//                    self.startStop = "Reset"
//                }
//            }
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
