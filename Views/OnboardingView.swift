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
            Text("Some tips are that you can also use this to split a bill using the split slider. Also, for both sliders, there are preset buttons below them to help you calculate your tip even faster!")
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
