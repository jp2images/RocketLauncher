//
//  ContentView.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 6/30/24.
//
///<a href="https://www.flaticon.com/free-icons/rocket" title="rocket icons">Rocket icons created by Freepik - Flaticon</a>

import SwiftUI

struct ContentView: View {
     
    @State var timeRemaining: Int = 0
    
    var body: some View {
        
        HStack {
            Image(systemName: "button.programmable.square")
                .imageScale(.large)
                .foregroundColor(.white)
            Text("Rocket Launcher!")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.largeTitle)
        }
        .background(Image("Galaxy")
            .aspectRatio(contentMode: .fit)
            .opacity(0.4))
                
        Launch(timeRemaining: $timeRemaining)
    }
}
    
#Preview {
    ContentView()
        //.colorScheme(.dark)
        //.background(Color.black)
}
