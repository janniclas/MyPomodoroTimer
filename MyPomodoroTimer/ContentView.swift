//
//  ContentView.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 31.10.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

            BackgroundView(imageName: "tea").overlay(alignment: .top) {
                TimerView(name: "Pomodoro", startTime: 4)
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
