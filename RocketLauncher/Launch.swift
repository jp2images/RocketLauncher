//
//  Launch.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 6/30/24.
//

import SwiftUI

struct Launch: View {
    @State private var radius: CGFloat = .zero
    
    var timeLeft: Int = 10
    var timeDone: Bool = false

    /// Each button needs a signal passed to start the countdown
    var start1: Bool = false
    var start2: Bool = false
    var body: some View {
        
        CountDownIndicator(timerValueString: "10",
                           radius: 200)
        Spacer()
        
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            LaunchButton(buttonText: "Left",
                         buttonWidth: 100,
                         buttonColor: .green,
                         buttonPressed: didPressButton,
                         buttonReleased: didReleaseButton)
            .padding([.leading], 40)
            Spacer()
            LaunchButton(buttonText: "Right",
                         buttonWidth: 100,
                         buttonColor: .green,
                         buttonPressed: didPressButton,
                         buttonReleased: didReleaseButton)
            .padding([.trailing], 40)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        
        Text("Press both buttons to begin countdown")
            .foregroundColor(.white)
    }
    
    /// A launch button is pressed
    func didPressButton(button: LaunchButton){
        // If pressed start countdown
    }
    
    func didReleaseButton(button: LaunchButton){
        // If released stop countdown
    }
}

#Preview {
    Launch()
        
}
