//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Tyler Geery on 1/31/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

    @IBAction func recordAudio(sender: UIButton) {
        recordingButton.hidden = true;
        recordingInProgress.hidden = false;
        stopButton.hidden = false;
    }
}

