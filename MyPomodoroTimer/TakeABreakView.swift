//
//  TakeABreakView.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 05.11.22.
//

import SwiftUI

struct TakeABreakView: View {
    private let mainScreenSize: CGSize
    init() {
        if let s = NSScreen.main?.visibleFrame.size {
            self.mainScreenSize = s
        } else {
            self.mainScreenSize = CGSize(width: 200, height: 200)
        }
    }
    
    var body: some View {
        
        ZStack {
            Color.green.opacity(0.8)
            VStack {
                Text("Take a Break!")
                Button("Take Break."){}
                Button("Skip Break."){}
            }
        }
        .ignoresSafeArea()
        .frame(width: mainScreenSize.width, height: mainScreenSize.height)
    }
    
}

struct TakeABreakView_Previews: PreviewProvider {
    static var previews: some View {
        TakeABreakView()
    }
}
