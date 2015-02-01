//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Tyler Geery on 1/31/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var receivedAudio:RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()

        if (receivedAudio.filePathUrl != nil) {
            audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
            audioPlayer.enableRate = true
        } else {
            println("The filepath is empty");
        }
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playSlowSound(sender: UIButton) {
        audioPlayer.stop()

        switch sender.tag {
        case 1:
            audioPlayer.rate = 0.5
        case 2:
            audioPlayer.rate = 2.0
        default:
            audioPlayer.rate = 1.0
        }

        audioPlayer.play()
    }

    @IBAction func playPitchAudio(sender: UIButton) {
        var pitch:Float!

        switch sender.tag {
        case 1:
            pitch = 1000
        case 2:
            pitch = -1000
        default:
            pitch = 0
        }

        playAudioWithPitch(pitch)
    }
    
    func playAudioWithPitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to:changePitchEffect, format:nil)
        audioEngine.connect(changePitchEffect, to:audioEngine.outputNode, format:nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
