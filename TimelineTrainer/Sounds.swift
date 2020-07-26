//
//  Sounds.swift
//  TimelineTrainer
//
//  Created by Brian King on 7/25/20.
//  Copyright © 2020 Brian King. All rights reserved.
//

import AVFoundation

 class Sounds {

   static var audioPlayer:AVAudioPlayer?

   static func playSounds(soundfile: String) {

       if let path = Bundle.main.path(forResource: soundfile, ofType: nil){

           do{

               audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
               audioPlayer?.prepareToPlay()
               audioPlayer?.play()

           }catch {
               print("Error")
           }
       }
    }
 }
