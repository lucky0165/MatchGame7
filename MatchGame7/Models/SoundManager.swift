//
//  SoundManager.swift
//  MatchGame7
//
//  Created by Łukasz Rajczewski on 03/03/2021.
//

import Foundation
import AVFoundation

class SoundManager {
    
    var player: AVAudioPlayer?
    
    enum soundType {
        case flip
        case correct
        case wrong
        case shuffle
    }
    
    
    func playSound(soundType: soundType) {
        
        var soundName = ""
        
        switch soundType {
        
            case .flip:
                soundName = "cardflip"
            case .correct:
                soundName = "dingcorrect"
            case .wrong:
                soundName = "dingwrong"
            case .shuffle:
                soundName = "shuffle"

        }
        
        if let path = Bundle.main.path(forResource: soundName, ofType: "wav") {
            
            let url = URL(fileURLWithPath: path)
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print(error)
            }
        }
  
    }
  
}
