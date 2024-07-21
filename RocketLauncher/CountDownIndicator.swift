//
//  CountDownIndicator.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 6/30/24.
//

import SwiftUI

struct CountDownIndicator: View {
    /// scenePhase is watching for the application to be the app on the main screen. When it goes
    /// to the background the app will go to sleep, but this takes a couple seconds and the timer will
    /// continue to countdow, Checking the scenePhase we can stop the timer immediately.
    @Environment(\.scenePhase) var scenePhase
    
    /// AppStorage loaded in the Launch() view
    @Binding var timerPreset: Int
    
    /// Bound variable and used in the Launch.Swift view
    @Binding var timeRemaining: Int
    
    // Loaded from the Launch() view
    @Binding var isEnabled: Bool
    
    @State private var isTimerRunning = false
    @State private var startTime = Date()
    @State private var indicatorColor: Color = .yellow
    
    ///Start a timer when the application starts.
    @State private var timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    ///When application starts up the scene is automatically active. So we start in the active state.
    @State private var isScenePhaseActive = true
    @State var firstTime: Bool = true
    
    var radius: Double = 200
    
    var body: some View {
        if timerPreset == timeRemaining{
            Text("The board is green. \nThe ship is ready for launch captian.")
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 30)
                .background(.regularMaterial, in:Capsule())
                .fontWeight(.bold)
                .foregroundColor(.green)
                .font(.headline)
        } else{
            ///Show no text but until I find a better way, we don't want the existing control view
            ///to shift position.
            Text("  \n")
                .padding([.top, .bottom], 10)
                .font(.headline)
        }
        HStack{
            let step = 1
            let range = 1...30
            
            Stepper(
                value: $timerPreset,
                in: range,
                step: step
            ) {
                Text("Timer preset: \(timerPreset)")
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.white)
            }
            .padding([.bottom], 10)
            .foregroundColor(.black)
            .onChange(of: step){
                if isEnabled{
                    timeRemaining = timerPreset
                }
            }
        }.frame(width: 235)
            .padding([.bottom], 20)
        Spacer()
        Text("\(timeRemaining)")
            .onReceive(timer){ time in
                if timeRemaining > 0{
                    if firstTime{
                        print("First Time: \(timeRemaining)")
                        firstTime = false
                    }
                    print("Timer running: \(isTimerRunning)")
                }
                
                if isEnabled{
                    guard isScenePhaseActive else { return }
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                        isTimerRunning = true
                        indicatorColor = .blue
                    }
                    
                    if timeRemaining <= 0 {
                        isTimerRunning = false
                        indicatorColor = .red
                        print("Blast Off!")
                        // TODO This is where we should turn on the Bluetooth
                        // signal to turn on the MCU realy output
                    }
                }
            }
        
        /// Verify if application is active app
            .onChange(of: scenePhase){
                isScenePhaseActive = (scenePhase == .active) ? true : false
            }
            .foregroundColor(.black)
            .font(.system(size: 72))
            .background(
                Ellipse()
                    .strokeBorder()
                    .fill(indicatorColor)
                    .frame(width: radius, height: radius)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 8, y: 8)
            )

            /// Reset the timer
            .onLongPressGesture{
                if !isEnabled{
                    timeRemaining = timerPreset
                    indicatorColor = .green
                }
            }
        
    }
}

#Preview {
    CountDownIndicator(timerPreset: .constant(70), 
                       timeRemaining: .constant(70),
                       isEnabled: .constant(false))
}
