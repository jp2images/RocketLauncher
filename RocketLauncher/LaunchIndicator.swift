//
//  LaunchIndicator.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 7/11/24.
//

import SwiftUI

struct LaunchIndicator: View {
    
    @State var isEnabled: Bool
    @State private var startTime = Date()
    @State private var indicatorColor: Color = .yellow
    
    ///When application starts up the scene is automatically active. So we start in the active state.
    @State private var isScenePhaseActive = true
    @State private var timeRemaining: Int = 0
    
    var radius: Double = 200
    
    var body: some View {
        Text("Filler")
    }
}

#Preview {
    LaunchIndicator(isEnabled: false)
}
