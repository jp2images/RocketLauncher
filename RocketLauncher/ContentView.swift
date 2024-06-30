//
//  ContentView.swift
//  RocketLauncher
//
//  Created by Jeff Patterson on 6/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image(systemName: "button.programmable.square")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Rocket Launcher!")
                .fontWeight(.bold)
                .foregroundColor(.black)
                .font(.largeTitle)
        }
        .padding()
            Launch()
    }
}

#Preview {
    ContentView()
}
