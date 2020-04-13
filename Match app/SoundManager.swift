//
//  SoundManager.swift
//  Match app
//
//  Created by Giorgi Jashiashvili on 4/13/20.
//  Copyright © 2020 Giorgi Jashiashvili. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
   static var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        
        case flip
        case shuffle
        case match
        case nomatch
        
        
    }
    
   static func playSound(_ effect:SoundEffect) {
        
        var soundFileName = ""
        
        switch effect {
        case .flip:
            soundFileName = "cardflip"
            
        case .shuffle:
            soundFileName = "shuffle"
            
        case .match:
        soundFileName = "dingcorrect"
            
        case .nomatch:
        soundFileName = "dingwrong"
            
        }
        // Get the path to the sound file inside the bundle
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Couldn't find song \(soundFileName)")
            return
        }
        
        // Create a URL object from this string path
            let SoundURL = URL(fileURLWithPath: bundlePath!)
        
        
        do {
            //Create audio player object
            audioPlayer = try AVAudioPlayer(contentsOf: SoundURL)
            
            audioPlayer?.play()
            
        } catch {
            print("couldn't create audio player")
        }
        
        
    }
    
    
    
}
