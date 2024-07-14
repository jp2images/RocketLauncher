//
//  Launch.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 6/30/24.
//

import SwiftUI

struct Launch: View {
    @Binding var timerPreset: Int
    
    //@Binding var timeRemaining: Int
    @State private var radius: CGFloat = .zero

    /// Enable the countdown. If button is release the coundown will stop and reset
    @State var isEnabled: Bool = false
    @State var isPressed: Bool = false
       
    var timeLeft: Int = 10
    var timeDone: Bool = false
    
    var body: some View {
        
        GeometryReader{geo in
            VStack {
                CountDownIndicator(isEnabled: $isEnabled, radius: 200)
                Spacer()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    LaunchButton(isEnabled: $isEnabled,
                                 buttonWidth: 150,
                                 buttonColor: .green,
                                 buttonPressed: didPressButton)//,
                                 //buttonReleased: didReleaseButton)
                    
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 5.0)
                            .onChanged({value in
                                if !isPressed {
                                    withAnimation(.linear(duration: Double(timerPreset))){
                                        isPressed = true
                                    }
                                }
                            })
                            .onEnded({_ in
                                if !isEnabled {
                                    isPressed = false
                                }
                            })
                        )
                    .simultaneousGesture(
                        LongPressGesture(minimumDuration: Double(timerPreset), maximumDistance: .infinity)
                            .onEnded({_ in
                            isPressed = true})
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
        isEnabled = true
        print("Pressed, Count: \(isEnabled)")
    }
    
    /// TODO The launch button is released. Not doing anything useful but keeping it around
    /// for the timer action to stop if the press wasn't long enough to launch.
    func didReleaseButton(button: LaunchButton){
        // If released stop countdown
        //isCountdownEnable = false
        print("Released, Count: \(isEnabled)")
    }
}

#Preview {
    Launch(timerPreset: .constant(7))
        .background(.gray)
}
