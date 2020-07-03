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
        self.prevTime = 0
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
        //components.hour = 0
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
                .fontWeight(.bold)
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
   
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State var showSettings = false
    @State var viewState = CGSize.zero
    
    @ObservedObject var timer = MKTimer()
    
    @ObservedObject var roundsGoal = TimerSettings()
    
    @State var roundsComplete = 0

    
        var body: some View {
            ZStack {
                GeometryReader{g in
                VStack {
                    TimerView(timer: self.timer)
                        .padding(.vertical, 100.0)
                        .font(.system(size: g.size.height > g.size.width ? g.size.width * 0.25 : g.size.height * 0.35, design: .monospaced))
                        .frame(width: UIScreen.main.bounds.size.width / 1.2,
                              height: 250,
                              alignment: .center)
                            .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                    
                        HStack {
                            Button(action: self.timer.changeRunningState) {
                                if self.timer.isRunning {
                                    
                                     Circle()
                                    .stroke(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), lineWidth: 6)
                                    .frame(width: 88, height: 88)
                            
                                    .overlay(
                                    Image(systemName: "pause.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                        .frame(width: 64, height: 55)
                                        )
                                    .contentShape(Rectangle())
               
                                } else {
                                    
                                Circle()
                                    .stroke(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), lineWidth: 6)
                                    .frame(width: 88, height: 88)
                                
                                    .overlay(
                                        Image(systemName: "play.fill")
                                        .resizable()
                                          .aspectRatio(contentMode: .fit)
                                            .offset(x: 6)
                                            .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                                            .frame(width: 44, height: 55)
                                        )
                                        
                                    .contentShape(Rectangle())
                                    
                                }
                            }
                            .padding(.horizontal)
                            .animation(.default)
                            
                            Spacer()
                            
                            if self.roundsGoal - self.roundsComplete == 1 {
                                Button(action: {self.timer.pause(); self.roundsComplete += 1}) {
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
                        
                            //gear button
                            
                            Spacer()
                            
                            Button(action:{
                             self.showSettings.toggle()
                          })
                          {
                            Circle()
                                   .stroke(Color(#colorLiteral(red: 0.3211478293, green: 0.4786565304, blue: 1, alpha: 1)), lineWidth: 6)
                                   .frame(width: 88, height: 88)
                              .overlay(
                                Image(systemName: "gear")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color(#colorLiteral(red: 0.3211478293, green: 0.4786565304, blue: 1, alpha: 1)))
                                .frame(width: 64, height: 55)
                             
                            )
                        }
                                
                            .padding(.horizontal)
                            .animation(.default)

                            
                        }
                            
                    .padding(.bottom, 75.0)
                        .frame(width: g.size.height > g.size.width ? g.size.width * 0.25 : g.size.width * 0.7)
                    //end HStack
                
                    HStack{
                        Spacer()
                        ForEach(0..<self.roundsGoal, id:\.self){i in
                            Group{
                                if self.roundsGoal < 10 {
                                    Image(systemName: i < self.roundsComplete ? "circle.fill" : "circle")
                                        .font(.system(size: 60))
                                        .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                    
                                    )
                                } else {
                                     Image(systemName: i < self.roundsComplete ? "circle.fill" : "circle")
                                         .font(.system(size: 30))
                                         .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                                     
                                     )
                                }
                              Spacer()
                            }
                        }
                    }
                    .padding(.bottom, 75.0)
                    .frame(width: g.size.height > g.size.width ? g.size.width * 0.5 : g.size.width * 0.7)

                    
                    
                    HStack {
                                            
                        if self.timer.isRunning {
                                
                                   
                            } else {
                                VStack {
                                    Button(action: {self.timer.restart(); self.roundsComplete = 0}) {
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
                                }
                            }
                        
                        

                    }
                    
                    
                    
                    
                           
                    
                    
                    
                    
                      Spacer()
                    
             
                            
                }
                }
                Group{
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
                }
                
            } //end ZStack
            } //end view
        } //end ContentView



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

