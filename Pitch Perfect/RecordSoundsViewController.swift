//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Cory Robinson on 8/23/20.
//  Copyright © 2020 Cory Robinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func recordButtonPress(_ sender: UIButton) {
        recordingLabel.text = "Recording in progress.."
        recordButton.isEnabled =  false
        stopRecordingButton.isEnabled = true
    }
    
    @IBAction func stopRecordButtonPress(_ sender: Any) {
        recordingLabel.text = "Tap to record again..."
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
    }
}

