//
//  CountDownIndicator.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 6/30/24.
//

import SwiftUI

struct CountDownIndicator: View {
    @State var isTimerRunning = false
    @State private var timerValue = 15
    @State var startTime = Date()
    @State var timerValueString = "10"
    
    @State private var timeRemaining = 10
    //let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    ///Start a timer when the application starts.
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                value: $timerValue,
                in: range,
                step: step
            ) {
                //Text("Timer Setting: \(timerValue)")
            }
            
        }
        .padding([.bottom], 40)
        
        Text("\(timeRemaining)")
            .onReceive(timer){ time in
                guard isScenePhaseActive else { return }
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
            }
            .onChange(of: scenePhase){
                if scenePhase == .active {
                    isScenePhaseActive = true
                } else{
                    isScenePhaseActive = false
                }
            }
        
        
        //Text(self.timerValueString)
        //            .onReceive(timer){ _ in
        //                if self.isTimerRunning {
        //                    timerValueString = String(format: "%0.0f", (Date().timeIntervalSince(self.startTime)))
        //                }
        //            }
        //            .onTapGesture {
        //                if isTimerRunning {
        //                    self.stopTimer()
        //                    timerValueString = "\(timerValue)"
        //                    startTime = Date()
        //                } else{
        //                    timerValueString = "\(timerValue)"
        //                    startTime = Date()
        //                    //Start UI updates
        //                    self.startTimer()
        //                }
        //                isTimerRunning.toggle()
        //                return
        //            }
            .foregroundColor(.black)
            .font(.system(size: 72))
            .background(
                Ellipse()
                    .strokeBorder()
                    .fill(.red)
                    .frame(width: radius, height: radius)
            )

        

    }
    
//    func stopTimer(){
//        self.timer.upstream.connect().cancel()
//    }
//    
//    func startTimer(){
//        self.timer = Timer.publish(every: 0.1, on: .main, in: .common)
//            .autoconnect()
//    }
    
}

#Preview {
    CountDownIndicator(timerValueString: "10")
}
