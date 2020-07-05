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
    @State var roundsComplete = 0

    @ObservedObject var settings = Settings()
    @ObservedObject var timer = TimerView.Timer()
    
    var body: some View {
        

        
        ZStack {
            VStack {
                
                //timer
                TimerView(timer: timer)
                //end timer
                
                //big button
                if settings.desiredRounds - self.roundsComplete == 1 {
                    Button(action: {self.roundsComplete += 1 ; timer.toggleRunningState()}) {
                                               Text("Finish Workout")
                                                   .font(.largeTitle)
                                                   .fontWeight(.bold)
                                                   .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                                                   .frame(width: 350, height: 88)
                                                   
                                                   .overlay(
                                                   RoundedRectangle(cornerRadius: 50)
                                                   .stroke(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), lineWidth: 6)
                                                   .frame(width: 350, height: 88)
                                                   )
                                                   
                                               }
                                              
                                           } else {
                                               Button(action: {self.roundsComplete += 1}) {
                                               Text("New Round")
                                                   .font(.largeTitle)
                                                   .fontWeight(.bold)
                                                   .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                                                   .frame(width: 350, height: 88)
                                                   
                                                   .overlay(
                                                   RoundedRectangle(cornerRadius: 50)
                                                   .stroke(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), lineWidth: 6)
                                                   .frame(width: 350, height: 88)
                                                   )
                                                   
                                               }
                                               
                                           }
                
                //end big button
                
                //rounds counters
                Text(" ")
                HStack{
                   Spacer()
                    ForEach(0..<settings.desiredRounds, id:\.self){i in
                       Group{
                        if self.settings.desiredRounds < 10 {
                               Image(systemName: i < self.roundsComplete ? "circle.fill" : "circle")
                                   .font(.system(size: 40))
                                   .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))

                               )
                           } else {
                                Image(systemName: i < self.roundsComplete ? "circle.fill" : "circle")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))

                                                    )
                                               }
                                             Spacer()
                                           }
                                       }
                                   }
                                   .padding(.bottom, 75.0)
                //end rounds counters
                                  
                Spacer()
                Text("\(settings.desiredRounds) Rounds")
                Button(action:{
                    self.showSettings.toggle(); timer.pause()
                })
                {
                    Text("Pause timer, mess with settings.")
                        .font(.title)
                }
                Spacer()
            } //that was the VStack
            
            SettingsView(settings: settings, timerView: timer)
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
                            self.showSettings = false; timer.resume()
                           }
                               self.viewState = .zero
                               }
                                   )
            
        } //That was the ZStack
        
        .onChange(of: settings.selectedWorkout) { workout in
                            if workout == .countDown {
                                self.timer.target = .down(from: 60)
                            } else {
                                self.timer.target = .up(to: 60)
                            }
                            self.timer.end()
                        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
