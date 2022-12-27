//
//  TestView.swift
//  Remember
//
//  Created by Mason Dierkes on 12/27/22.
//

import SwiftUI

struct TestView: View {
    let colors: [Color] = [.red, .green, .blue]

    var body: some View {
           ZStack {
               VStack {
                   LinearGradient(
                       gradient: Gradient(colors: [.black, Color.black.opacity(0)]),
                       startPoint: .top,
                       endPoint: .bottom
                   )
                   .ignoresSafeArea()
                   .frame(height: 100)
                   Spacer()
               }
               
               // Other content goes here
           }
       }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
