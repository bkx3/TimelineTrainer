//
//  TimerView+Extensions.swift
//  TimelineTrainer
//
//  Created by Brian King on 7/3/20.
//  Copyright © 2020 Brian King. All rights reserved.
//

import Foundation
import SwiftUI

struct TimerView: View {
    @ObservedObject var timer: TimerView.Timer
    let timePublisher = Foundation.Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(
        target: TimerView.Timer.Target? = nil,
        onStart: ((TimeInterval)->())? = nil,
        onUpdate: ((TimeInterval)->())? = nil,
        onPause: ((TimeInterval)->())? = nil,
        onResume: ((TimeInterval)->())? = nil,
        onEnd: ((TimeInterval)->())? = nil
    ) {
        self.timer = TimerView.Timer(
            target: target,
            onStart: onStart,
            onUpdate: onUpdate,
            onPause: onPause,
            onResume: onResume,
            onEnd: onEnd
        )
    }
    
    init(timer: TimerView.Timer) {
        self.timer = timer
    }
    
    var body: some View {
        VStack(spacing: 10) {
     
            Text("\(self.timer.timeComponents, formatter: TimerView.Timer.formatter)")
                .padding(.vertical, 100.0)
                .font(.system(size: 100, design: .monospaced))
                   .frame(width: UIScreen.main.bounds.size.width / 1.2,
                         height: 250,
                         alignment: .center)
                       .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
            
            HStack(spacing: 100.0){
                
                
            // Pause/Resume button
//            Button(action: self.timer.toggleRunningState) {
//                Circle()
//                    .stroke(Color(.green), lineWidth: 4)
//                .frame(width: 88, height: 88)
//
//                    .overlay(
//                Image(systemName: self.timer.isRunning ? "pause.fill" : "play.fill")
//                )
//            }.font(.system(size: 50))
//                .foregroundColor(.green)
//            .animation(.default)
                
                
                
            
            // Restart Button
//            Button(action:self.timer.start) {
//                Circle()
//                   .stroke(Color(.blue), lineWidth: 4)
//               .frame(width: 88, height: 88)
//
//                   .overlay(
//                Image(systemName: self.timer.isCountdown ? "arrow.counterclockwise.circle" : "arrow.clockwise.circle")
//                )
//            }.font(.system(size: 50))
//                .foregroundColor(.blue)
//                .animation(.default)
                
                
            
            // Stop Button
//            Button(action: self.timer.end) {
//                Circle()
//                    .stroke(Color(.red), lineWidth: 4)
//                .frame(width: 88, height: 88)
//                
//                    .overlay(
//                Image(systemName: "stop.fill")
//                )
//            }.font(.system(size: 50))
//                .foregroundColor(.red)
//                .animation(.default)
                
                
                
            }
        }
        .onReceive(timePublisher) { _ in
            self.timer.update()
        }
        .onAppear {
            self.timer.start()
        }
    }
}

extension TimerView {
    class Timer: ObservableObject {
        private var startDate: Date
        private var currentDate: Date
        private var prevTime: TimeInterval = 0
        
        var target: Target?
        
        @Published var time: TimeInterval = 0
        @Published var isRunning: Bool = false
        
        var onStart: ((TimeInterval)->())?
        var onUpdate: ((TimeInterval)->())?
        var onPause: ((TimeInterval)->())?
        var onResume: ((TimeInterval)->())?
        var onEnd: ((TimeInterval)->())?
        
        
        init(
            target: Target? = nil,
            onStart: ((TimeInterval)->())? = nil,
            onUpdate: ((TimeInterval)->())? = nil,
            onPause: ((TimeInterval)->())? = nil,
            onResume: ((TimeInterval)->())? = nil,
            onEnd: ((TimeInterval)->())? = nil
        ) {
            self.startDate = Date()
            self.currentDate = Date()
            self.target = target
            self.onStart = onStart
            self.onUpdate = onUpdate
            self.onPause = onPause
            self.onResume = onResume
            self.onEnd = onEnd
            
        }
        
        func start() {
            isRunning = false
            startDate = Date()
            time = 0
            prevTime = 0
            
            switch target {
            case .down(let countdown):
                time = countdown
            default:
                break
            }
            
            onStart?(time)
        }
        
        func pause() {
            isRunning = false
            switch target {
            case .down(let countdown):
                prevTime = countdown - time
            default:
                prevTime = time
            }
            onPause?(time)
        }
        
        func resume() {
            startDate = Date()
            isRunning = true
            onResume?(time)
        }
        
        func end() {
            isRunning = false
            onEnd?(time)
            startDate = Date()
            time = 0
            prevTime = 0
        }
        
        func toggleRunningState() {
            if self.isRunning {
                pause()
            } else {
                resume()
            }
        }
        
        func update() {
            guard isRunning else { return }
            currentDate = Date()
            let currentInterval = currentDate.timeIntervalSince(startDate)
            
            
            switch target {
            case .down(let countdown):
                time = countdown - (prevTime + currentInterval)
                if time <= 0 {
                    self.end()
                }
            case .up(let countup):
                time = prevTime + currentInterval
                if Int(time) >= Int(countup) {
                    self.end()
                }
            case nil:
                time = prevTime + currentInterval
            }
            
            onUpdate?(time)
        }
        
        
        enum Target {
            case down(from: TimeInterval)
            case up(to: TimeInterval)
        }

    }
}


extension TimerView.Timer {
    var elapsed: (Int, Int, Int) {
        let intervalInteger = Int(time)
        let hours = intervalInteger / 3600
        let minutes = (intervalInteger % 3600) / 60
        let seconds = (intervalInteger % 3600) % 60
        return (hours, minutes, seconds)
    }
    
    // This is a different way to implement John's DateComponents suggestion
    // This fits better with SwiftUI IMO
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
    
    var isCountdown: Bool {
        self.target != nil
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
ContentView()
        
    }
}
