//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Tyler Geery on 1/31/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!

    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidDisappear(animated: Bool) {
        recordingButton.hidden = false;
        recordingInProgress.hidden = true;
        stopButton.hidden = true;
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag) {
            // Save recorder audio
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            
            // Perform segue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("The file did not save correctly");
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingButton.hidden = true;
        recordingInProgress.hidden = false;
        stopButton.hidden = false;

        audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        recordingInProgress.hidden = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)

    }
}

