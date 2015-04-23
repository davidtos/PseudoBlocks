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
    
    
    var AudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("01-intro", ofType: "mp3")!)
    
    var AudioPlayer = AVAudioPlayer()
    
    func start() {
        AudioPlayer = AVAudioPlayer(contentsOfURL: AudioURL, error: nil)
        self.PlaySound()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(5 * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            println("test")
            self.AudioPlayer.stop()
        }
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