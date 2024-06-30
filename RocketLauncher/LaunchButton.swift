//
//  LaunchButton.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 6/30/24.
//

import SwiftUI

struct LaunchButton: View {
    @State private var radius: CGFloat = .zero
    
    var buttonText: String = "Btn"
    var buttonTextColor: Color = .white
    var buttonWidth: CGFloat = 150
    var buttonColor: Color = Color(red: 0.15,
                                   green: 0.15,
                                   blue: 0.15,
                                   opacity: 1.0)
    
    var buttonPressed: (LaunchButton) -> Void = {_ in } // Default value of "Empty Closure" a function or method that has no name.
    
    var buttonReleased: (LaunchButton) -> Void = {_ in } // Default value of "Empty Closure" a function or method that has no name.
    
    var body: some View {
        Button {
            buttonPressed(self)
            buttonReleased(self)
            
        } label: {
            Text(buttonText)
                .font(.largeTitle)
            //.fontWeight(.heavy)
                .frame(width: buttonWidth,
                       height: buttonWidth,
                       alignment: .center)
                .background(buttonColor)
                .foregroundColor(buttonTextColor)
                .clipShape(RoundedRectangle(cornerRadius:(buttonWidth/2)))
        }
    }
}

#Preview {
    LaunchButton()
}
