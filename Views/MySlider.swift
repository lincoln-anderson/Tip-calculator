//
//  SwiftUIView.swift
//  
//
//  Created by lincoln anderson on 3/16/22.
//

import SwiftUI

struct MySlider: View {
    @Binding var passedStateVariable: Double
    var bottom: Double
    var top: Double
    var step: Double
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
            Text(String(Int(bottom)))
            Slider(value: $passedStateVariable, in: bottom...top, step: step)
                .accentColor(colorScheme == .dark ? .white : .black)
            Text(String(Int(top)))
        }
    }
}
