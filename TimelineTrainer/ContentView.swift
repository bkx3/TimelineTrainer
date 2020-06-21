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

    //Timer logic
    @State var startDate = Date()
    @State var currentDate = Date()
    @State var elapsed: (Int, Int, Int) = (0,0,0)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //End timer logic
    
    
    var body: some View {
        ZStack {

           VStack(spacing: 2) {
                                
            //Timer Text
           Text("\(elapsed.1, specifier: "%02d"):\(elapsed.2, specifier: "%02d")")
             .font(.system(size: 185, design: .monospaced))
            .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                .onReceive(timer) { _ in
                    self.currentDate = Date()
                    let interval = Int(self.currentDate.timeIntervalSince(self.startDate))
                    let hours = interval / 3600
                    let minutes = (interval % 3600) / 60
                    let seconds = (interval % 3600) % 60
                    self.elapsed = (hours, minutes, seconds)
                }

                
            //TimerButtons()
            HStack {
                       
                       Spacer()
                       
                       Button(action:{}){
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
                       Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
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
                                
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text("Temporary timer starter for dummies")
            }
            .padding(.top)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                       Text("Temporary timer stopper for dummies")
                       }
                       .padding(.top)

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

