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

    @ObservedObject var settings = Settings()
    
    var body: some View {
        

        
        ZStack {
            VStack {
                TimerView(target: .down(from: 60))
//                HStack{
//                                       Spacer()
//                                       ForEach(0..<self.roundsGoal, id:\.self){i in
//                                           Group{
//                                               if self.roundsGoal < 10 {
//                                                   Image(systemName: i < self.roundsComplete ? "circle.fill" : "circle")
//                                                       .font(.system(size: 60))
//                                                       .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
//
//                                                   )
//                                               } else {
//                                                    Image(systemName: i < self.roundsComplete ? "circle.fill" : "circle")
//                                                        .font(.system(size: 30))
//                                                        .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
//
//                                                    )
//                                               }
//                                             Spacer()
//                                           }
//                                       }
//                                   }
//                                   .padding(.bottom, 75.0)
                                  
                Spacer()
                Text("\(settings.desiredRounds) Rounds")
                Button(action:{
                   self.showSettings.toggle()
                })
                {
                    Text("Settings")
                        .font(.title)
                }
                Spacer()
            } //that was the VStack
            
            SettingsView(settings: self.settings)
                       .background(Color.black.opacity(0.001))
                       .offset(y: showSettings ? 0 : 900)
                       .offset(y: viewState.height)
                       .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
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
