//
//  ContentView.swift
//  TimelineTrainer
//
//  Created by Brian King on 6/18/20.
//  Copyright © 2020 Brian King. All rights reserved.
//

import SwiftUI
import Combine

struct StopWatchButtonLeft : View {
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
                Image(systemName: (self.icon[0]))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                  .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                  .frame(width: 64, height: 64)
                    .offset(x: 6)
                  
                  .overlay(
                      Circle()
                          .stroke(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), lineWidth: 6)
                          .frame(width: 88, height: 88))
            } else {
                 Image(systemName: (self.icon[1]))
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .foregroundColor(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                     .frame(width: 64, height: 64)
                     
                     
                     .overlay(
                         Circle()
                             .stroke(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), lineWidth: 6)
                             .frame(width: 88, height: 88))
            }
        }
       
    }
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
               Text("Paused")
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
                                  height: 200,
                                  alignment: .center)

                
            //TimerButtons()
            HStack {
                       
        HStack{
            
            Spacer()
                    StopWatchButtonLeft(actions: [self.stopWatch.start, self.stopWatch.pause],
                        icon: ["play", "pause"],
                        isPaused: self.stopWatch.isPaused())
                        .padding(.horizontal)
                    
                    StopWatchButtonMiddle(actions: [self.stopWatch.start, self.stopWatch.lap],
                    icon: ["arrow.counterclockwise", "plus"],
                    isPaused: self.stopWatch.isPaused())
                    .padding(.horizontal)
                       
                 
                       
                       
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
                     Text("Rounds")
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


