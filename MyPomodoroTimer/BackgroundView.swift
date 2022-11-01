//
//  BackgroundView.swift
//  MyPomodoroTimer
//
//  Created by Jan-Niclas Strüwer on 01.11.22.
//

import SwiftUI

struct BackgroundView: View {
    let imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 300, minHeight: 300)
            .clipped()
            .ignoresSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(imageName: "tea")
    }
}
