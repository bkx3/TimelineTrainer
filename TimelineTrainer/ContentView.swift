//
//  ContentView.swift
//  TimelineTrainer
//
//  Created by Brian King on 6/18/20.
//  Copyright © 2020 Brian King. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 2) {
            
            //Clock goes here
            
            Text("20:43")
                .font(.system(size: 150, design: .monospaced))
                .fontWeight(.black)
                .frame(minWidth: 0, maxWidth: .infinity)
                
            
            
            //Here are some buttons
            
            HStack {
                
                Spacer()
                
                Image(systemName: "pause.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                    .padding()
                
               Spacer()
                
                
                //New Round Button
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("NEW ROUND")
                        .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                        .stroke(Color(#colorLiteral(red: 0, green: 0.7816944718, blue: 0.3346565366, alpha: 1)), lineWidth: 5)
                            .frame(width: 400.0, height: 100.0)
                    )
                    
                }
                .frame(height: 100)
                
            Spacer()
                
                Image(systemName:"gear")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                    .padding()
           
                
                Spacer()
            }
                
                //that was the end of the HStack full of buttons
                
                
        .frame(width: 800)
            
            //welcome to the timeline
            
            ZStack {
                
                HStack {
                    Circle()
                        .frame(height: 25)
                    
                    Circle()
                    .frame(height: 25)
                    
                    Circle()
                    .frame(height: 25)
                    
                    Circle()
                    .frame(height: 25)
                    
                    Circle()
                    .frame(height: 25)
                }
                
                Rectangle()
                    .frame(height: 8)
            }
            .padding(.all)
            
            Spacer()
            
            //this is the vstack full of records
            VStack(alignment: .trailing) {
                HStack {
                    Text("Fastest")
                        .font(.system(size: 50))
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing)
                    Text("03:15")
                        .font(.system(size: 50, design: .monospaced))
                        .multilineTextAlignment(.leading)
                }
                
                HStack {
                    Text("Current")
                        .font(.system(size: 50))
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing)
                    Text("03:15")
                        .font(.system(size: 50, design: .monospaced))
                        .multilineTextAlignment(.leading)
                }
                
                HStack {
                    Text("Average")
                        .font(.system(size: 50))
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing)
                    Text("03:15")
                        .font(.system(size: 50, design: .monospaced))
                        .multilineTextAlignment(.leading)
                }
                
                
            }
            
            Spacer()
        }
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
