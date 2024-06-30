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
    var body: some View {
        
        CountDownIndicator(startTime: Date(),
                           timerValueString: "10",
                           radius: 250)
        .padding(100)
        
        HStack(spacing: 100) {
            LaunchButton(buttonText: "Left",
                         buttonWidth: 100,
                         buttonColor: .green,
                         buttonPressed: didPressButton,
                         buttonReleased: didReleaseButton)
            
            LaunchButton(buttonText: "Right",
                         buttonWidth: 100,
                         buttonColor: .green,
                         buttonPressed: didPressButton,
                         buttonReleased: didReleaseButton)
        }
        Text("Press both buttons to begin countdown")
            .padding()
    }
    
    /// A launch button is pressed
    func didPressButton(button: LaunchButton){
        // If pressed start countdown
    }
    
    func didReleaseButton(button: LaunchButton){
        // If released stop countdown
    }
    
    //    func startTimer() -> Bool{
    //        Timer.scheduledTimer(timeInterval: 1.0, repeats: false){
    //            timer in
    //            print("TImer fired")
    //            timeLeft -= 1
    //            if timeLeft == 0 {
    //                timer.invalidate()
    //                return true
    //            }
    //        }
    //    }
}

#Preview {
    Launch()
}
