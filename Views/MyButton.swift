//
//  SwiftUIView.swift
//  
//
//  Created by lincoln anderson on 3/16/22.
//

import SwiftUI

struct MyButton: View {
    @Binding var passedStateVariable: Double
    var passedVariable: Double
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Spacer()
        Button {
            passedStateVariable = passedVariable
        } label: {
            Text(String(Int(passedVariable)))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .font(.title2)
                .fontWeight(.bold)
        }
        Spacer()
    }
}
