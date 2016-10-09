//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Abidi on 10/8/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
    }
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        setUIElementsState(recordButtonEnabled: false, stopButtonEnabled: true, recordingLabel: "Recording...")

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let filePath = NSURL.fileURL(withPathComponents: [dirPath, "recordedVoice.wav"])
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        setUIElementsState(recordButtonEnabled: true, stopButtonEnabled: false, recordingLabel: "Tap to Record")
        audioRecorder.stop()
        try! AVAudioSession.sharedInstance().setActive(false)
    }
    
    func setUIElementsState(recordButtonEnabled recordButtonIsEnabled: Bool, stopButtonEnabled: Bool, recordingLabel: String) {
        self.recordButton.isEnabled = recordButtonIsEnabled
        self.stopButton.isEnabled = stopButtonEnabled
        self.recordingLabel.text = recordingLabel
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Failed to save audio!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playAudioVC = segue.destination as! PlaySoundsViewController
            let recordedFileURL = sender as! NSURL
            playAudioVC.recordedAudioURL = recordedFileURL
        }
    }
}

