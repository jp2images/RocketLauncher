//
//  LaunchButton.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 6/30/24.
//

import SwiftUI

struct LaunchButton: View {
    @Binding var isEnabled: Bool
    @State private var radius: CGFloat = .zero

    var buttonWidth: CGFloat = 150
    var buttonColor: Color = Color(red: 0.15,
                                   green: 0.15,
                                   blue: 0.15,
                                   opacity: 1.0)
    
    /// Default value of "Empty Closure" a function or method that has no name.
    var buttonPressed: (LaunchButton) -> Void = {_ in }
    var buttonReleased: (LaunchButton) -> Void = {_ in }
    
    var body: some View {
        Button {
            buttonPressed(self)
            buttonReleased(self)
            
        } label: {/// Label is a closure that is available when not using parameters for the
                  /// button function.
            Image("Button")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        }
        .frame(width: buttonWidth,
               height: buttonWidth * 0.7,
               alignment: .center)
        .background(buttonColor)
        .clipShape(RoundedRectangle(cornerRadius:(buttonWidth/2)))
        .shadow(radius: 5, x: 8, y: 8)
    }
}

#Preview {
    LaunchButton(isEnabled: .constant(false), buttonColor: .blue)
}


