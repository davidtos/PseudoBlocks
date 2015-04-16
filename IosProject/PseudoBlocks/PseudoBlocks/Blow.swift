//
//  Blow.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation
import AVFoundation

// uses microphone to detect if player is blowing in the mic in order to remove dust

class Blow: Block {
    
    var audioRecorder:AVAudioRecorder!
    
    var audioPlayer = AVAudioPlayer()
    
    func start() {
        
        // record sound for 5 seconds
        var url = self.record()
        usleep(5)
        audioRecorder.stop()
        
        // play recorded sound for 5 seconds
        AVAudioPlayer(contentsOfURL: url, error: nil)
        
        audioPlayer.play()
        usleep(5)
        audioPlayer.stop()
        
    }
    
    
    
    func record() -> NSURL{
        
        var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioSession.setActive(true, error: nil)
        
        var documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
        var str =  documents.stringByAppendingPathComponent("recordTest.caf")
        var url = NSURL.fileURLWithPath(str as String)
        
        var recordSettings = [AVFormatIDKey:kAudioFormatAppleIMA4,
            AVSampleRateKey:44100.0,
            AVNumberOfChannelsKey:2,AVEncoderBitRateKey:12800,
            AVLinearPCMBitDepthKey:16,
            AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
            
        ]
        
        println("url : \(url)")
        var error: NSError?
        
        audioRecorder = AVAudioRecorder(URL:url, settings: recordSettings as [NSObject : AnyObject], error: &error)
        if let e = error {
            println(e.localizedDescription)
        } else {
            
            audioRecorder.record()
        }
        return url!;
    }
}