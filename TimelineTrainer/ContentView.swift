//
//  ContentView.swift
//  TimelineTrainer
//
//  Created by Brian King on 6/18/20.
//  Copyright © 2020 Brian King. All rights reserved.
//


import SwiftUI

struct ContentView: View {
    
    @State var showSettings = false
    @State var viewState = CGSize.zero

    
    var body: some View {
        

        
        ZStack {
            VStack {
                TimerView(target: .down(from: 60))
                Spacer()
                Button(action:{
                   self.showSettings.toggle()
                })
                {
                    Text("Settings")
                        .font(.title)
                }
                Spacer()
            } //that was the VStack
            
            SettingsView()
                       .background(Color.black.opacity(0.001))
                       .offset(y: showSettings ? 0 : 900)
                       .offset(y: viewState.height)
                       .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                       .onTapGesture {
                           self.showSettings.toggle()
                               }
                       .gesture(
                           DragGesture() .onChanged { value in
                           self.viewState = value.translation
                               }
                           .onEnded { value in
                           if self.viewState.height > 50 {
                               self.showSettings = false
                           }
                               self.viewState = .zero
                               }
                                   )
            
        } //That was the ZStack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
