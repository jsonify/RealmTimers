//
//  Sound.swift
//  RealmTimers
//
//  Created by Jason Rueckert on 8/13/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import AVFoundation
import Foundation

class Sound {
    
    static let shared = Sound()
    var audioPlayer: AVAudioPlayer?
    
    func startSound() {
        let path = Bundle.main.path(forResource: "rain", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print(error)
            // couldn't load file :(
        }
    }
    
    func stopSound() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
}
