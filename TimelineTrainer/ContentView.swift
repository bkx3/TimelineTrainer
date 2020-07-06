//
//  ContentView.swift
//  TimelineTrainer
//
//  Created by Brian King on 6/18/20.
//  Copyright © 2020 Brian King. All rights reserved.
//


import SwiftUI

struct ContentView: View {
    
    @State var showSettings: Bool = false
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
                
                //rounds counters
                Text(" ")
                HStack{
                   Spacer()
                    ForEach(0..<settings.desiredRounds, id:\.self){i in
                       Group{
                        if self.settings.desiredRounds < 10 {
                               Image(systemName: i < self.roundsComplete ? "circle.fill" : "circle")
                                .font(Font.title.weight(.bold))
                                .foregroundColor(Color.gray)

                               
                           } else {
                                Image(systemName: i < self.roundsComplete ? "circle.fill" : "circle")
                                    .font(Font.title.weight(.bold))
                                    .foregroundColor(Color("TrainerGreen")

                                                    )
                                               }
                                             Spacer()
                                           }
                                       }
                                   }
                                   .padding(.bottom, 55.0)
                //end rounds counters
                Text("\(self.roundsComplete)/5 COMPLETE")
                    .font(Font.system(size: 45, weight: .semibold))
                    .foregroundColor(Color.gray)
                
                //big button
                if settings.desiredRounds - self.roundsComplete == 1 {
                    Button(action: {self.roundsComplete += 1 ; timer.toggleRunningState()}) {
                                               Text("Finish Workout")
                                                   .font(.largeTitle)
                                                   .fontWeight(.bold)
                                                   .foregroundColor(Color("TrainerGreen"))
                                                   .frame(width: 350, height: 88)
                                                   
                                                   .overlay(
                                                   RoundedRectangle(cornerRadius: 50)
                                                   .stroke(Color("TrainerGreen"), lineWidth: 6)
                                                   .frame(width: 350, height: 88)
                                                   )}
                        .padding(.top, 55.0)
                                                   
                                        } else if settings.desiredRounds == self.roundsComplete {
                                            Button(action: {self.roundsComplete += 1}) {
                                            Text("Workout Complete")
                                                .font(.largeTitle)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                                .frame(width: 350, height: 88)
                                                
                                                .overlay(
                                                RoundedRectangle(cornerRadius: 50)
                                                .stroke(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), lineWidth: 6)
                                                .frame(width: 350, height: 88)
                                                )}
                                                .disabled(true)
                                              
                                           } else {
                                               Button(action: {self.roundsComplete += 1}) {
                                               Text("New Round")
                                                   .font(.largeTitle)
                                                   .fontWeight(.bold)
                                                   .foregroundColor(Color("TrainerGreen"))
                                                   .frame(width: 350, height: 88)
                                                   
                                                   .overlay(
                                                   RoundedRectangle(cornerRadius: 50)
                                                   .stroke(Color("TrainerGreen"), lineWidth: 6)
                                                   .frame(width: 350, height: 88)
                                                   )}
                                                .padding(.top, 55.0)
                                               
                                           }
                
                //end big button
                Spacer()
                
                
                Group{
                 if self.timer.isRunning {
                    Button(action:{
                    self.showSettings.toggle() ; timer.pause()
                    })
                            {
                           Circle()
                               .stroke(Color(.red), lineWidth: 4)
                               .frame(width: 88, height: 88)

                               .overlay(
                               Image(systemName: "pause.fill")
                               )
                                   }.font(.system(size: 50))
                                   .foregroundColor(.red)
                                    .animation(.default)
                    
                } else if settings.desiredRounds == self.roundsComplete {
                    Button(action: {self.showSettings.toggle()}) {
                               Circle()
                                   .stroke(Color(.blue), lineWidth: 4)
                                   .frame(width: 88, height: 88)

                                   .overlay(
                               Image(systemName: "gear")
                               )
                                   }.font(.system(size: 50))
                                   .foregroundColor(.blue)
                                    .animation(.default)

                } else {
                    Button(action: {self.showSettings.toggle()}) {
                               Circle()
                                   .stroke(Color("TrainerGreen"), lineWidth: 4)
                                   .frame(width: 88, height: 88)

                                   .overlay(
                               Image(systemName: "play.fill")
                                .offset(x: 4)
                               )
                                   }.font(.system(size: 50))
                                   .foregroundColor(Color("TrainerGreen"))
                                    .animation(.default)                }

                } //end group
                .padding(.all)
               
            }
             //that was the VStack
            
            if self.showSettings == true {
                SettingsView(settings: settings, timerView: timer)
                           .background(Color.black.opacity(0.001))
//                           .offset(y: showSettings ? 0 : 1200)
                           .offset(y: viewState.height)
                            .transition(.move(edge: .bottom))
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
                    .onTapGesture {
                        withAnimation(Animation.spring()){
                            self.showSettings.toggle()
                        }
                    }
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }

            
        } //ends Zstack
        
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//That was the ZStack
        
        .onChange(of: settings.selectedWorkout) { workout in
                            if workout == .countDown {
                                self.timer.target = .down(from: settings.desiredTime)
                            } else {
                                self.timer.target = .up(to: settings.desiredTime)
                            }
                            self.timer.end()
                        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
               ContentView()
                  .environment(\.colorScheme, .light)

               ContentView()
                  .environment(\.colorScheme, .dark)
            }
    }
}
