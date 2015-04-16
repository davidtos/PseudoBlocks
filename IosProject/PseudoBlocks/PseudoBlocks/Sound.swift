//
//  Sound.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation
import AVFoundation
// uses musicplayer to execute sound to wake up enemies in front of teh player

class Sound: Block {
    
    
    var AudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("SnesMusic", ofType: "mp3")!)
    
    var AudioPlayer = AVAudioPlayer()
    
    func start() {
        AudioPlayer = AVAudioPlayer(contentsOfURL: AudioURL, error: nil)
        self.PlaySound()
        usleep(10)
        self.StopSound()
    }

    func PlaySound(){
        AudioPlayer.play()
    }
    
    func StopSound()
    {
        AudioPlayer.stop()
        AudioPlayer.currentTime = 0;
    }
}