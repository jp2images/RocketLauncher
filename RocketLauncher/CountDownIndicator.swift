//
//  CountDownIndicator.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 6/30/24.
//

import SwiftUI

struct CountDownIndicator: View {
    @AppStorage("TimerPreset") var timerPresetValue: Int = 15
    
    @State var isTimerRunning = false
    //@State private var timerValue = 15
    @State var startTime = Date()
    @State var timerValueString = "10"
    @State var indicatorColor: Color = .yellow
    @State private var timeRemaining = 10
    
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
    
    var radius: Double = 200
        
    var body: some View {
        HStack{
            let step = 1
            let range = 1...30
            
            Stepper(
                value: $timerPresetValue,
                in: range,
                step: step
            ) {
                Text("Timer preset: \(timerPresetValue)")
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.white)
            }
            .padding([.bottom], 10)
            .foregroundColor(.black)
            .onChange(of: step){
                timeRemaining = timerPresetValue
            }
        }.frame(width: 235)
            .padding([.bottom], 20)
        Spacer()
        
        Text("\(timeRemaining)")
            .onReceive(timer){ time in
                guard isScenePhaseActive else { return }
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
                if timeRemaining <= 0 {
                    indicatorColor = .red
                    isTimerRunning = false
                }
            }
            .onTapGesture {
                if isTimerRunning {
                    //timeRemaining = timerValue
                }
            }
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
            )
            .onLongPressGesture{
                if !isTimerRunning{
                    timeRemaining = timerPresetValue
                    indicatorColor = .yellow
                    print("Long press isTimerRunning: \(isTimerRunning)")
                }
                print("isTimerRunning: \(isTimerRunning)")
            }
    }
}

#Preview {
    CountDownIndicator(timerValueString: "15")
}
