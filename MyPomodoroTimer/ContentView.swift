//
//  ContentView.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 31.10.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TimerView(name: "Pomodoro", startTime: 4)
            Text("Hello ")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
