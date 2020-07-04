//
//  SettingsView.swift
//  TimelineTrainer
//
//  Created by Brian King on 6/20/20.
//  Copyright © 2020 Brian King. All rights reserved.
//
import SwiftUI

struct SettingsView: View {
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
                        
                        Button(action: {}) {
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
