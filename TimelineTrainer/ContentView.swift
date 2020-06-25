//
//  ContentView.swift
//  TimelineTrainer
//
//  Created by Brian King on 6/18/20.
//  Copyright © 2020 Brian King. All rights reserved.
//

import SwiftUI
import Combine

class MKTimer: ObservableObject {
    var startDate: Date
    var currentDate: Date
    var prevTime: TimeInterval = 0
    
    @Published var time: TimeInterval = 0
    @Published var isRunning: Bool = false
    
    init() {
        self.startDate = Date()
        self.currentDate = Date()
        self.time = 0
    }
    
    func start() {
        self.isRunning = true
        self.startDate = Date()
    }
    
    func pause() {
        self.isRunning = false
        self.prevTime = self.time
    }
    
    func resume() {
        self.startDate = Date()
        self.isRunning = true
    }
    
    func restart(){
        self.isRunning = false
        self.startDate = Date()
        self.currentDate = Date()
        self.time = 0
    }
    
    func changeRunningState() {
        if self.isRunning {
            self.pause()
        } else {
            self.resume()
        }
    }
    
    func update() {
        guard self.isRunning else { return }
        self.currentDate = Date()
        let currentInterval = self.currentDate.timeIntervalSince(self.startDate)
        self.time = self.prevTime + currentInterval
    }
}

extension MKTimer {
    var timeComponents: DateComponents {
        var components = DateComponents()
        components.hour = 0
        components.minute = 0
        components.second = Int(time)
        return components
    }
    
    static var formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
}

struct TimerView: View {
    @ObservedObject var timer = MKTimer()
    
    let timePublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            Text("\(self.timer.timeComponents, formatter: MKTimer.formatter)")
        }
        .onReceive(timePublisher) { _ in
            self.timer.update()
        }
        .onAppear {
            self.timer.pause()
        }
    }
}

struct ContentView: View {
    @State var showSettings = false
    @State var viewState = CGSize.zero
    
 @ObservedObject var timer = MKTimer()
    
    @State var rounds = 0
    @State var roundsGoal = 5

    
        var body: some View {
            ZStack {
                VStack {
                        TimerView(timer: timer)
                        .font(.system(size: 150, design: .monospaced))
                           .frame(width: UIScreen.main.bounds.size.width,
                              height: 200,
                              alignment: .center)
                        
                     
                        HStack {
                            Button(action: self.timer.changeRunningState) {
                                if timer.isRunning {
                                    Image(systemName: "pause.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                    .frame(width: 50, height: 50)
                                      
                                        
                                    .overlay(
                                        Circle()
                                            .stroke(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), lineWidth: 6)
                                            .frame(width: 88, height: 88))
                                    .contentShape(Rectangle())
                                    
                                    
                                } else {
                                    Image(systemName: "play.fill")
                                    .resizable()
                                      .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                                        .frame(width: 50, height: 50)
                                        .offset(x: 6)
                                        
                                        .overlay(
                                            Circle()
                                            .stroke(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), lineWidth: 6)
                                            .frame(width: 88, height: 88))
                                    .contentShape(Rectangle())

                                } //end else
                            }
                            .padding(.horizontal)
                            .animation(.default)
                            
                            
                            //new button. useless button.
                            
                            if self.roundsGoal - self.rounds == 1 {
                                Button(action: {self.rounds += 1}) {
                                Text("Finish Workout")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                                    .frame(width: 350, height: 88)
                                    
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), lineWidth: 6)
                                    .frame(width: 350, height: 88))
                                    
                                }
                                .padding(.all, 30.0)
                            } else {
                                Button(action: {self.rounds += 1}) {
                                Text("New Round")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                                    .frame(width: 350, height: 88)
                                    
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), lineWidth: 6)
                                    .frame(width: 350, height: 88))
                                    
                                }
                                .padding(.all, 30.0)
                            }
                        
                            //gear button
                            
                            Button(action:{
                             self.showSettings.toggle()
                          })
                          {
                              Image(systemName: "gear")
                              .resizable()
                              .aspectRatio(contentMode: .fill)
                              .foregroundColor(Color(#colorLiteral(red: 0.3211478293, green: 0.4786565304, blue: 1, alpha: 1)))
                              .frame(width: 64, height: 64)
                              
                              
                              .overlay(
                                  Circle()
                                      .stroke(Color(#colorLiteral(red: 0.3211478293, green: 0.4786565304, blue: 1, alpha: 1)), lineWidth: 6)
                                      .frame(width: 88, height: 88)
                            )}
                                .padding(.horizontal)
                            
                            
                            
                        } //end HStack
                          
//                    Text("\(rounds) Rounds Complete")
                    
                    if self.rounds == 1 {
                        Text("\(rounds) Round Complete")
                    } else {
                        Text("\(rounds) Rounds Complete")
                    }
                    
                    if self.roundsGoal - self.rounds == 1 {
                          Text("\(self.roundsGoal - self.rounds) round to go!")
                      } else {
                          Text("\(self.roundsGoal - self.rounds) rounds to go")
                      }
                    
                    
                    HStack {
                        Spacer()
                        Stepper(value: $roundsGoal, in: 0...26){
                            Text("Goal: \(roundsGoal) rounds")
                        
                        }
                    
                        
                        Spacer()
                    }
                    .frame(width:300)
                    
                    Button(action: {self.timer.restart(); self.rounds = 0}) {
                                     Text("Reset")
                                      .font(.headline)
                                      .fontWeight(.bold)
                                     
                                     .foregroundColor(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                     .padding()
                                     .overlay(
                                         RoundedRectangle(cornerRadius: 50)
                                          .stroke(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), lineWidth: 3)
                                          .frame(width: 150.0, height: 40.0)
                                                 )
                                                 
                    }
                    .padding(.vertical)
                    
                    
                           
                    
                    
                    
                    
                      Spacer()
                    
             
                            
                }
                MenuView()
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
                
            } //end ZStack
            } //end view
        } //end ContentView

struct MenuView: View {
@ObservedObject var timer = MKTimer()
    
    var body: some View {
         
        
        VStack {
            Spacer()
            VStack (spacing: 10) {
                
                Text("Timed Workout")
                    .font(.largeTitle)
                    .padding(.top)
              
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("5 rounds")
                }
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Goal: 25m 00s")
                }
                .padding(.bottom)
                
                
              Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                          Text("Start in 10s")
                            .font(.headline)
                            .fontWeight(.bold)
                          
                          .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                          .padding()
                          .overlay(
                              RoundedRectangle(cornerRadius: 50)
                              .stroke(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), lineWidth: 3)
                                .frame(width: 150.0, height: 40.0)
                          )
                          
              }
              .padding(.vertical, 50.0)
                          .frame(height: 22)
                
                
                  Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                           Text("Start in 30s")
                            .font(.headline)
                            .fontWeight(.bold)
                           
                           .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                           .padding()
                           .overlay(
                               RoundedRectangle(cornerRadius: 50)
                                .stroke(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), lineWidth: 3)
                                .frame(width: 150.0, height: 40.0)
                                       )
                                       
                  }
                    Spacer()
                  .padding(.top, 40.0)
                    .frame(height: 22)
                
                Button(action: {self.timer.restart()}) {
                  Text("Restart")
                   .font(.headline)
                   .fontWeight(.bold)
                  
                  .foregroundColor(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                  .padding()
                  .overlay(
                      RoundedRectangle(cornerRadius: 50)
                       .stroke(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), lineWidth: 3)
                       .frame(width: 150.0, height: 40.0)
                              )
                              
         }
                
            }
            .frame(maxWidth: 500)
            .frame(height: 350)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.8705882353, green: 0.8941176471, blue: 0.9450980392, alpha: 1))]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)            .padding(.horizontal, 30)
           Spacer()

        }
        .padding(.top, 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

