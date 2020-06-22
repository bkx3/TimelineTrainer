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


struct StopWatchButtonMiddle : View {
    var actions: [() -> Void]
    var icon: [String]
    var isPaused: Bool
    
    var body: some View {
        
        return Button(action: {
            if self.isPaused {
                self.actions[0]()
            } else {
                self.actions[1]()
            }
        }) {
            if isPaused {
               Text("Reset?")
                .font(.largeTitle)
                       .fontWeight(.bold)
                      .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                      .frame(width: 350, height: 88)
                  
                  
                  .overlay(
                      RoundedRectangle(cornerRadius: 50)
                          .stroke(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), lineWidth: 6)
                          .frame(width: 350, height: 88))
            } else {
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
        }
        
    }
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
    
        var body: some View {
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
                            } //end else
                        }
                        .animation(.default)
                        
                        
                        //new button. useless button.
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
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
                        .padding(.all, 20.0)
                    
                        //gear button
                        
                        
                        
                    } //end HStack
                              
                  Spacer()
                        
                }
            }
        }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

