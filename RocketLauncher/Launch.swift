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
   
    /// Enable the countdown. If button is release the coundown will stop and reset
    @State var isEnabled: Bool = false
    @State var isPressed: Bool = false
    
    @State private var radius: CGFloat = .zero

    var timeLeft: Int = 10
    var timeDone: Bool = false
    
    var body: some View {
        
        GeometryReader{geo in
            VStack {
                CountDownIndicator(timerPreset: $timerPreset,
                                   timeRemaining: $timeRemaining, 
                                   isEnabled: $isEnabled,
                                   radius: 200)
                Spacer()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    LaunchButton(isEnabled: $isEnabled,
                                 buttonWidth: 150,
                                 buttonColor: .green,
                                 buttonPressed: didPressButton,
                                 buttonReleased: didReleaseButton)
                    
                    .simultaneousGesture(
                        /// DragGesture is equivalent to both button down and button up in windows
                        /// the minimum distance is how much movement before the event fires.
                        DragGesture(minimumDistance: 0.0)
                        /// onChanged notifies when the user touches and releases
                            .onChanged({_ in
                                print("ButtonDown")
                                isPressed = true
                                
                                if timeRemaining == timerPreset{
                                    isEnabled = true
                                    print("isEnabled: \(isEnabled)")
                                }
                            })
                        /// onEnded Notifies when the user releases
                            .onEnded({_ in
                                isPressed = false
                                isEnabled = false
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
    
    /// TODO These launch buttons not doing anything useful but keeping it around
    func didPressButton(button: LaunchButton){
        // If pressed start countdown
    }
    
    func didReleaseButton(button: LaunchButton){
        // If released stop countdown
    }
}

#Preview {
    Launch(timeRemaining: .constant(8))
        .background(.gray)
        .colorScheme(.dark)
}
