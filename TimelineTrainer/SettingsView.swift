//
//  SettingsView.swift
//  TimelineTrainer
//
//  Created by Brian King on 6/20/20.
//  Copyright © 2020 Brian King. All rights reserved.
//
import SwiftUI


class Settings: ObservableObject {
    @Published var selectedWorkout = TimerType.countUp
    @Published var desiredRounds: Int = 5
    @Published var desiredTime: TimeInterval = 0
    @Published var userTime: Int = 0
}

struct SettingsView: View {
    
    @ObservedObject var settings: Settings
    @ObservedObject var timerView: TimerView.Timer

    var body: some View {
        
         VStack {
                    Spacer()
                    VStack (spacing: 10) {
                        
                        if settings.selectedWorkout == TimerType.countUp {
                            Text("Timed Workout")
                                .font(.largeTitle)
                                .padding(.top)
                        } else {
                            Text("AMRAP Countdown")
                                .font(.largeTitle)
                                .padding(.top)
                        }
                      
                        
                       
//                            if settings.desiredRounds == 0 {
//                                Text("As many rounds as possible")
//                            } else {
//                                if settings.desiredRounds == 1 {
//                                Text("\(settings.desiredRounds) round")
//                                } else {
//                                    Text("\(settings.desiredRounds) rounds")
//                                }
//                            }
//                        
//                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
//                        Text("Goal: 25m 00s")
//                        }
//                        .padding(.bottom)
                        
                        Picker(selection: $settings.selectedWorkout, label: Text("Pick workout"))
                        {
                            ForEach(TimerType.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 300)
                        .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                        HStack {
                            Picker("Number of rounds", selection: $settings.desiredRounds){
                                ForEach(0..<26){
                                    Text("\($0)")
                                }
                            }
                            .labelsHidden()
                            .frame(width: 80, height: 80)
                            .clipped()
                            if settings.desiredRounds == 1 {
                            Text("round")
                            } else {
                                Text("rounds")
                            }
                        }
                        //time picker
                        HStack {
                            Picker("Number of minutes", selection: $settings.desiredTime){
                                ForEach(1..<60){
                                    Text("\($0)").tag( Double($0*60))
                                }
                            }
                            .labelsHidden()
                            .frame(width: 80, height: 80)
                            .clipped()
                            if settings.desiredTime == 1 {
                            Text("minute")
                            } else {
                                Text("minutes")
                            }
                        }
                     
                        
                        Spacer()
                        
                        //little shit button test
                        Button(action: {self.settings.desiredTime = Double(120)}) {
                            Text("Two minute timer set")
                        }
                        
                        
                        
                        
                        //start buttons
                        Button(action: {timerView.start()}
                               ) {
                                  Text("Start Now")
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
                        
                        
                        Button(action: {timerView.end()}) {
                                   Text("Reset Timer")
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
                            Spacer()
                          .padding(.top, 40.0)
                            .frame(height: 22)
                    
                        
                    }
                    //Build out the window
                    .frame(maxWidth: 500)
                    .frame(height: 600)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("SettingsGradTop"), Color("SettingsGradBottom")]), startPoint: .top, endPoint: .bottom))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)            .padding(.horizontal, 30)
                   Spacer()
            //that's the window!

                }
                .padding(.top, 30)
            }
        }
    
    enum TimerType: String, CaseIterable {
        case countUp
        case countDown
    }
    

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

