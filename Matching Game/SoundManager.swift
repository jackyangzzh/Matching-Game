//
//  SoundManager.swift
//  Matching Game
//
//  Created by Zongzhen Yang on 1/29/19.
//  Copyright © 2019 JackYang. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        case flip
        case shuffle
        case match
        case noMatch
    }
    
    func playSound( effect:SoundEffect) {
        var soundFileName = ""
        
        switch effect{
        case .flip:
            soundFileName = "cardFlip"
        case .shuffle:
            soundFileName = "shuffle"
        case .match:
            soundFileName = "dingcorrect"
        case .noMatch:
            soundFileName = "dingwrong"
        }
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        
        guard bundlePath != nil else{
            print("Couldn't find sound file \(soundFileName)")
            return
        }
        
        //Create URL object from this string path
        let soundUrl = URL(fileURLWithPath: bundlePath!)
        
        //Create audio player object
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            audioPlayer?.play()
        }catch{
            print("Couldn't create the audio player for sound file \(soundFileName)")
        }
        
        
    }
}
