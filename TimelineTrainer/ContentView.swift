//
//  ContentView.swift
//  TimelineTrainer
//
//  Created by Brian King on 6/18/20.
//  Copyright © 2020 Brian King. All rights reserved.
//

import SwiftUI
import Combine

struct StopWatchButton : View {
    var actions: [() -> Void]
    var labels: [String]
    var color: Color
    var isPaused: Bool
    
    var body: some View {
        let buttonWidth = (UIScreen.main.bounds.size.width / 2) - 12
        
        return Button(action: {
            if self.isPaused {
                self.actions[0]()
            } else {
                self.actions[1]()
            }
        }) {
            if isPaused {
                Text(self.labels[0])
                    .foregroundColor(Color.white)
                    .frame(width: buttonWidth,
                           height: 50)
            } else {
                Text(self.labels[1])
                    .foregroundColor(Color.white)
                    .frame(width: buttonWidth,
                           height: 50)
            }
        }
        .background(self.color)
    }
}

struct ContentView: View {
    @State var showSettings = false
    @State var viewState = CGSize.zero
    
    @ObservedObject var stopWatch = StopWatch()

    var body: some View {
        ZStack {

           VStack(spacing: 2) {
                                
       Text(self.stopWatch.stopWatchTime)
                           .font(.custom("courier", size: 70))
                           .frame(width: UIScreen.main.bounds.size.width,
                                  height: 300,
                                  alignment: .center)

                
            //TimerButtons()
            HStack {
                       
                       Spacer()
                       
                       Button(action:{self.stopWatch.pause()}){
                           Image(systemName: "pause")
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .foregroundColor(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                               .frame(width: 64, height: 40)
                               
                               
                               .overlay(
                                   Circle()
                                       .stroke(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), lineWidth: 6)
                                       .frame(width: 88, height: 88)
                           )}
                           .padding(.trailing)
                       
                       Spacer()
                       
                       
                       
                       //the green New Round Button
                       Button(action: {self.stopWatch.lap()}) {
                           Text("NEW ROUND")
                               .font(.largeTitle)
                               .fontWeight(.bold)
                               
                               .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                               .padding()
                               .overlay(
                                   RoundedRectangle(cornerRadius: 50)
                                       .stroke(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), lineWidth: 5)
                                       .frame(width: 400.0, height: 100.0)
                           )
                           
                       }
                       .frame(height: 88)
                       
                       Spacer()
                       
                       
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
                           .padding(.leading)
                       
                       Spacer()
                       
                       
                       
                   }
                                
            Button(action: {self.stopWatch.start()}) {
            Text("Temporary timer starter for dummies")
            }
            .padding(.top)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                       Text("Temporary timer stopper for dummies")
                       }
                       .padding(.top)
            
            VStack(alignment: .leading) {
                     Text("Laps")
                         .font(.title)
                         .padding()

                     List {
                         ForEach(self.stopWatch.laps, id: \.uuid) { (lapItem) in
                             Text(lapItem.stringTime)
                         }
                     }
                 }

//            .frame(width: 800)
                            
            //TimelineView()

                Spacer()
                
//                //this is the vstack full of records
//                VStack(alignment: .trailing) {
//                    HStack {
//                        Text("Fastest")
//                            .font(.system(size: 50))
//                            .multilineTextAlignment(.trailing)
//                            .padding(.trailing)
//                        Text("03:15")
//                            .font(.system(size: 50, design: .monospaced))
//                            .multilineTextAlignment(.leading)
//                    }
//
//                    HStack {
//                        Text("Current")
//                            .font(.system(size: 50))
//                            .multilineTextAlignment(.trailing)
//                            .padding(.trailing)
//                        Text("03:15")
//                            .font(.system(size: 50, design: .monospaced))
//                            .multilineTextAlignment(.leading)
//                    }
//
//                    HStack {
//                        Text("Average")
//                            .font(.system(size: 50))
//                            .multilineTextAlignment(.trailing)
//                            .padding(.trailing)
//                        Text("03:15")
//                            .font(.system(size: 50, design: .monospaced))
//                            .multilineTextAlignment(.leading)
//                    }
//
//
//                }
//
//                Spacer()
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

        }
     
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





struct TimelineView: View {
    var body: some View {
        ZStack {
            
            HStack {
                Circle()
                    .frame(height: 25)
                
                Circle()
                    .frame(height: 25)
                
                Circle()
                    .stroke(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), lineWidth: 6)
                    .frame(height: 25)
                
                Circle()
                    .stroke(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), lineWidth: 6)
                    .frame(height: 25)
                
                
                Circle()
                    .overlay(
                        Circle()
                            .stroke(Color(.black),lineWidth: 6)
                ).foregroundColor(.white)
                    .frame(height:25)
            }
            
            Rectangle()
                .frame(height: 8)
        }
        .padding(.all, 75)
    }
}


//LMAO timer logic

