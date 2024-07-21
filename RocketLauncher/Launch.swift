//
//  Launch.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 6/30/24.
//

import SwiftUI

struct Launch: View {
    @AppStorage("TimerPreset") var timerPreset: Int = 15
    
    @Binding var timeRemaining: Int
    @Binding var timerPreset: Int
    
    @State private var radius: CGFloat = .zero

    /// Enable the countdown. If button is release the coundown will stop and reset
    @State var isEnabled: Bool = false
    @State var isPressed: Bool = false

    var timeLeft: Int = 10
    var timeDone: Bool = false
    
    var body: some View {
        
        GeometryReader{geo in
            VStack {
                CountDownIndicator(timerPreset: $timerPreset,
                                   isEnabled: $isEnabled, radius: 200)
                Spacer()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    LaunchButton(isEnabled: $isEnabled,
                                 buttonWidth: 150,
                                 buttonColor: .green,
                                 //buttonPressed: didPressButton)//,
                                 buttonReleased: didReleaseButton)
                    
                    .simultaneousGesture(
                        /// DragGesture is equivalent to both button down and button up in windows
                        /// the minimum distance is how much movement before the event fires.
                        DragGesture(minimumDistance: 0.0)
                        /// onChanged notifies when the user touches
                            .onChanged({_ in
                                print("ButtonDown")
                                if timeRemaining == timerPreset{
                                    isPressed = true
                                    isEnabled = true
                                }
                            })
                        ///onEnded Notifies when the user releases
                            .onEnded({_ in
                                isPressed = false
                                isEnabled = false
                                print("ButtonUp")
                            })
                    )
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
        isEnabled = false
        print("Pressed, Count: \(isEnabled)")
    }
    
    /// TODO The launch button is released. Not doing anything useful but keeping it around
    /// for the timer action to stop if the press wasn't long enough to launch.
    func didReleaseButton(button: LaunchButton){
        // If released stop countdown
        isPressed = false
        print("Launch Released")
        print("isPressed: \(isPressed)")
        print("isEnabled: \(isEnabled)")
    }
}

#Preview {
    Launch(timeRemaining: timeRemaining, timerPreset: timerPreset)
        .background(.gray)
}
