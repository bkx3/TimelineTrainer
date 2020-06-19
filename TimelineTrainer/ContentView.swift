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
                .font(.system(size: 150))
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
                
                Spacer()
            }
        .frame(width: 800)
               Spacer()
        }
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
