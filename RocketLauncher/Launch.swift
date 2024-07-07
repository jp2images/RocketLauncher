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

    /// Enable the countdown. If button is release the coundown will stop and reset
    @State var isCountdownEnable: Bool = false
    
    var body: some View {
        
        GeometryReader{geo in
            VStack {
                CountDownIndicator(isCountEnabled: $isCountdownEnable, radius: 200)
                Spacer()
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    LaunchButton(buttonText: "Launch",
                                 buttonWidth: 150,
                                 buttonColor: .green,
                                 buttonPressed: didPressButton,
                                 buttonReleased: didReleaseButton)
                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                
                //Text("Press both buttons to begin countdown")
                Text("Press and hold button until countdown completes to launch")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: geo.size.width * 0.7)
            }
        }
    }
    
    /// A launch button is pressed
    func didPressButton(button: LaunchButton){
        // If pressed start countdown
        isCountdownEnable = true
        print("Enable Count: \(isCountdownEnable)")
    }
    
    func didReleaseButton(button: LaunchButton){
        // If released stop countdown
        //isCountdownEnable = false
        print("Disable Count: \(isCountdownEnable)")
    }
}

#Preview {
    Launch()
        
}
