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
    
    
    var player:Player
    
    init(p:Player)
    {
        self.player = p
    }
    
    
    var audioRecorder:AVAudioRecorder!
    
    var audioPlayer = AVAudioPlayer()
    
    func start() {
        
        // record sound for 5 seconds
        println("recording started")
        
        
        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        //println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
        
        //var url = self.record()
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(3 * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            println("recording stopped")
            self.audioRecorder.stop()
            // play recorded sound for 5 seconds
            self.audioPlayer = AVAudioPlayer(contentsOfURL: filePath, error: nil)
            println("playing started")
            self.audioPlayer.play()
            self.walk()
        }
                
        dispatch_after(delayTime, dispatch_get_main_queue()) {}
        
        //self.audioPlayer.stop()
        
    }
    
    func walk()
    {
        
        var tile :Tile
        
        switch player.derection{
            
        case WalkDirection.right:
            tile = player.scene.getTile(player.tile.column + 1, row: player.tile.row)!
            if(tile.tileType == TileType.dust){
                player.scene.movePlayer(tile)
            }
            else {
                tile = player.scene.getTile(player.tile.column, row: player.tile.row)!
            }
            //println("1c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        case WalkDirection.up:
            tile = player.scene.getTile(player.tile.column, row: player.tile.row + 1)!
            if(tile.tileType == TileType.dust){
                player.scene.movePlayer(tile)
            }
            else {
                tile = player.scene.getTile(player.tile.column, row: player.tile.row)!
            }
            // println("2c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        case WalkDirection.down:
            tile = player.scene.getTile(player.tile.column, row: player.tile.row - 1)!
            if(tile.tileType == TileType.dust){
                player.scene.movePlayer(tile)
            }
            else {
                tile = player.scene.getTile(player.tile.column, row: player.tile.row)!
            }
            // println("3c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        case WalkDirection.left:
            tile = player.scene.getTile(player.tile.column - 1, row: player.tile.row)!
            if(tile.tileType == TileType.dust){
                player.scene.movePlayer(tile)
            }
            else {
                tile = player.scene.getTile(player.tile.column, row: player.tile.row)!
            }
            // println("4c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        default:
            tile = player.tile
            break
        }
        println("x:\(tile.column) y:\(tile.row)")
        player.tile = tile
        
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