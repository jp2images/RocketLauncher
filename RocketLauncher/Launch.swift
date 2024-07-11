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
                    LaunchButton(isEnabled: $isCountdownEnable,
                                 buttonWidth: 150,
                                 buttonColor: .green,
                                 buttonPressed: didPressButton,
                                 buttonReleased: didReleaseButton)
                    // .onLongPressGesture{
//                        isCountdownEnable = true
//                        print("Long press")
//                        if !isCountEnabled{
//                            timeRemaining = timerPreset
//                            indicatorColor = .yellow
//                        }
//                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                Text("Press and hold button until countdown completes to launch")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: geo.size.width * 0.7)
            }
        }
    }
    
    /// The launch button is pressed
    func didPressButton(button: LaunchButton){
        // If pressed start countdown
        isCountdownEnable = true
        print("Pressed, Count: \(isCountdownEnable)")
    }
    
    /// TODO The launch button is released. Not doing anything useful but keeping it around
    /// for the timer action to stop if the press wasn't long enough to launch.
    func didReleaseButton(button: LaunchButton){
        // If released stop countdown
        //isCountdownEnable = false
        print("Released, Count: \(isCountdownEnable)")
    }
}

#Preview {
    Launch()
        .background(.gray)
        
}
