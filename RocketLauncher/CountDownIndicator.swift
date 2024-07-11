//
//  CountDownIndicator.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 6/30/24.
//

import SwiftUI

struct CountDownIndicator: View {
    @AppStorage("TimerPreset") var timerPreset: Int = 15
    
    @Binding var isCountEnabled: Bool
    
    @State private var isTimerRunning = false
    @State private var startTime = Date()
    @State private var indicatorColor: Color = .yellow
    
    ///Start a timer when the application starts.
    @State private var timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    /// scenePhase is watching for the application to be the app on the main screen. When it goes
    /// to the background the app will go to sleep, but this takes a couple seconds and the timer will
    /// continue to countdow, Checking the scenePhase we can stop the timer immediately.
    @Environment(\.scenePhase) var scenePhase
    
    ///When application starts up the scene is automatically active. So we start in the active state.
    @State private var isScenePhaseActive = true
    @State private var timeRemaining: Int = 0
    
    var radius: Double = 200
    
    var body: some View {
        if timerPreset == timeRemaining{
            Text("The ship is ready captian and the board is green")
                .fontWeight(.thin)
                .foregroundColor(.green)
            //.foregroundStyle(.ultraThickMaterial)
                .font(.headline)
        } else{
            Text(" ")
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
                if isCountEnabled{
                    timeRemaining = timerPreset
                }
            }
        }.frame(width: 235)
            .padding([.bottom], 20)
        Spacer()
        Text("\(timeRemaining)")
            .onReceive(timer){ time in
                if timeRemaining > 0{
                    print("Time: \(timeRemaining)")
                    if isCountEnabled{
                        print("Counting: \(isCountEnabled)")
                    }
                }
                
                if isCountEnabled{
                    guard isScenePhaseActive else { return }
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                        isCountEnabled = true
                        isTimerRunning = true
                    }
                    
                    if timeRemaining <= 0 {
                        isTimerRunning = false
                        indicatorColor = .red
                        isCountEnabled = false
                        // TODO This is where we should turn on the Bluetooth
                        // signal to turn on the MCU realy output
                    }
                } else if !isTimerRunning {
                    //                    timeRemaining = timerPreset
                    //                    isTimerRunning = false
                    //                    isCountDone = true
                    //indicatorColor = .yellow
                }
            }
        //            .onTapGesture {
        //                if isTimerRunning == false {
        //                    //timeRemaining = timerValue
        //                    //isTimerRunning = true
        //                }
        //            }
        /// Verify if application is active app
            .onChange(of: scenePhase){
                if scenePhase == .active {
                    isScenePhaseActive = true
                } else{
                    isScenePhaseActive = false
                }
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
                if !isCountEnabled{
                    timeRemaining = timerPreset
                    indicatorColor = .yellow
                }
            }
    }
}

#Preview {
    CountDownIndicator(isCountEnabled: .constant(false))
}
