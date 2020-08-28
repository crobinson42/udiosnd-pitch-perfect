//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Cory Robinson on 8/23/20.
//  Copyright © 2020 Cory Robinson. All rights reserved.
//

import AVFoundation
import UIKit

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        recordingLabel.text = "Recording in progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        do {
            try audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
            
            audioRecorder.delegate = self
            
            print("audioRecorder initialized")
        } catch {
            print(error)
        }
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
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
        
        audioRecorder.stop()

        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("audioRecorderDidFinishRecording, flag \(flag)")
        
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: recorder.url)
        } else {
            let alert = UIAlertController(title: "Error", message: "There was a problem with saving the recording", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                alert.dismiss(animated: true)
            })

            alert.addAction(ok)
            
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioUrl = sender as! URL
            playSoundsVC.recordedAudioUrl = recordedAudioUrl
        }
    }
}

