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
    
    @State var workoutStatus = "preWorkout"
    //three states: preWorkout, inWorkout and postWorkout. Use this to simplify SuperButton status?

    @ObservedObject var settings = Settings()
    @ObservedObject var timer = TimerView.Timer()
    
    @State var tap = false
    @State var press = false
    
    func advanceRounds() {
        if settings.desiredRounds - self.roundsComplete == 1 {
            self.roundsComplete += 1 ; timer.toggleRunningState()
        }
        
       else if self.roundsComplete >= settings.desiredRounds {
        }
       
       else {
            self.roundsComplete += 1
        }
                       }
    
    var body: some View {
        ZStack {
            VStack {
                
                Spacer()
                //timer
                TimerView(timer: timer)
                    .onTapGesture{
                        advanceRounds()
                                       }
                //end timer
                
                //rounds counters
                Text(" ")
                HStack{
                   Spacer()
                    ForEach(0..<settings.desiredRounds, id:\.self){i in
                       Group{
                        if self.settings.desiredRounds < 10 {
                               Image(systemName: i < self.roundsComplete ? "circle.fill" : "circle")
                                .font(.system(size: 45, weight: .bold))
                                .foregroundColor(Color("TrainerGreen"))
                             

                               
                           } else {
                                Image(systemName: i < self.roundsComplete ? "circle.fill" : "circle")
                                    .font(Font.title.weight(.bold))
                                    .foregroundColor(Color("TrainerGreen"))
                                               }
                                             Spacer()
                                           }
                                       }
               
                    }
                .contentShape(Rectangle())
                .onTapGesture{
                    advanceRounds()
                                   }
                                   .padding(.bottom, 55.0)
                //end rounds counters
                VStack {
                    if self.roundsComplete != settings.desiredRounds {
                        Text("\(self.roundsComplete)/\(settings.desiredRounds) COMPLETE")
                        .font(Font.system(size: 45, weight: .semibold))
                            .foregroundColor(Color.gray)
                    } else {
                        Text("WORKOUT COMPLETE")
                        .font(Font.system(size: 45, weight: .semibold))
                            .foregroundColor(Color.gray)
                    }
                }
                
                //begin super button
                
                if self.roundsComplete == 0, timer.isRunning == false {
                    Button(action: {timer.resume()})
                    {
                        Text("Begin Workout")
                            .fontWeight(.bold)
                    }
                    .buttonStyle(SuperButton())
                    .padding(.top, 55.0)
                    
            } else if settings.desiredRounds - self.roundsComplete == 1 {
                Button(action: {self.roundsComplete += 1 ; timer.toggleRunningState()})
                {
                    Text("Finish Workout")
                        .fontWeight(.bold)
                }
                .buttonStyle(SuperButton())
                .padding(.top, 55.0)
                
                                                   
                                        } else if settings.desiredRounds <= self.roundsComplete {
                                            //Button(action: {self.roundsComplete = 0}) {
                                            Text("Hold to Reset")
                                                .font(.largeTitle)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("TrainerRed"))
                                                .frame(width: 350, height: 88)
                                                
                                                .overlay(
                                                RoundedRectangle(cornerRadius: 50)
                                                .stroke(Color("TrainerRed"), lineWidth: 6)
                                                .frame(width: 350, height: 88)
                                                )
                                                
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 50)
                                                        .trim(from: tap ? 0.001 : 1, to: 1)
                                                        .stroke(Color( press ? .yellow : .blue), lineWidth: 8)
                                                        .frame(width: 350, height: 88)
                                                )
                                                //                                                .onLongPressGesture(minimumDuration: 2) {
//                                                    self.roundsComplete = 0
//                                                }
                                                .gesture(
                                                    LongPressGesture(minimumDuration: 2.0).onChanged { value in
                                                        self.tap = true
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                                                            self.tap = false
                                                        }
                                                    }
                                                    .onEnded { value in
                                                        self.press.toggle(); self.roundsComplete = 0
                                                    }
                                                )
                                            
                                        
                                                .padding(.top, 55.0)

                                              
                                           } else {
                                            Button(action: {self.roundsComplete += 1})
                                            {
                                                Text("New Round")
                                                    .fontWeight(.bold)
                                            }
                                            .buttonStyle(SuperButton())
                                            .padding(.top, 55.0)
                                               
                                           }
                
                //end SuperButton
                
               
                
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
                                   .stroke(Color("TrainerGreen"), lineWidth: 4)
                                   .frame(width: 88, height: 88)

                                   .overlay(
                               Image(systemName: "gear")
                               )
                                   }.font(.system(size: 50))
                                   .foregroundColor(Color("TrainerGreen"))
                                    .animation(.default)

                } else {
                    Button(action: {self.showSettings.toggle()}) {
                               Circle()
                                   .stroke(Color("TrainerGreen"), lineWidth: 4)
                                   .frame(width: 88, height: 88)

                                   .overlay(
                               Image(systemName: "gear")
                                .offset(x: 0)
                               )
                                   }.font(.system(size: 50))
                                   .foregroundColor(Color("TrainerGreen"))
                                    .animation(.default)                }

                } //end group
                .padding(.bottom, 55.0)
               
            }
             //that was the VStack
            
            if self.showSettings == true {
                SettingsView(settings: settings, timerView: timer)
                           .background(Color.black.opacity(0.001))
                           .offset(y: viewState.height)
                            .transition(.move(edge: .bottom))
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
//                    .onTapGesture {
//                        withAnimation(Animation.spring()){
//                            self.showSettings.toggle()
//                        }
//                    }
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
        .onChange(of: settings.desiredTime) { time in
            if settings.selectedWorkout == .countDown {
                self.timer.target = .down(from: time)
            } else {
                self.timer.target = .up(to: time)
            }
            self.timer.end()
        }
    }
}

//struct Shake: GeometryEffect {
//    var amount: CGFloat = 10
//    var shakesPerUnit = 3
//
//    func effectValue(size: CGSize) -> ProjectionTransform {
//        ProjectionTransform(CGAffineTransform(translationX:
//            amount * sin(3 * .pi * CGFloat(shakesPerUnit)),
//            y: 0))
//    }
//}

struct SuperButton: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .foregroundColor(Color("TrainerGreen"))
            .frame(width: 350, height: 88)

            .overlay(
            RoundedRectangle(cornerRadius: 50)
            .stroke(Color("TrainerGreen"), lineWidth: 6)
            .frame(width: 350, height: 88)
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
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

extension UIView {
    enum GlowEffect: Float {
        case small = 0.4, normal = 2, big = 30
    }

    func doGlowAnimation(withColor color: UIColor, withEffect effect: GlowEffect = .normal) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 0.8
        layer.shadowOffset = .zero

        let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.fromValue = 0
        glowAnimation.toValue = effect.rawValue
        glowAnimation.fillMode = .removed
        glowAnimation.repeatCount = .infinity
        glowAnimation.duration = 2
        glowAnimation.autoreverses = true
        layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
    }
}
