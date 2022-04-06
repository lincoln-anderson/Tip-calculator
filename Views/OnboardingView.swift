//
//  SwiftUIView.swift
//  
//
//  Created by lincoln anderson on 4/6/22.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack{
            Text("Hello, thank you for using my tip calculator")
            Text("You can split a bill using the split slider which will show you the per person cost. Also, for both sliders, there are preset buttons below them to help you calculate your tip even faster!")
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
