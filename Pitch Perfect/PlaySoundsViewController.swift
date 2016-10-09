//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Abidi on 10/8/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    enum sounds: Int { case chipMunk = 0, darthVader, echo, fast, slow, reverb }
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(playState: .NotPlaying)
    }
    
    @IBAction func playChangedAudio(_ sender: AnyObject) {
        configureUI(playState: .Playing)
        switch (sounds(rawValue: sender.tag)!) {
        case .chipMunk:
            playSound(pitch: -1000)
        case .darthVader:
            playSound(pitch: 1000)
        case .echo:
            playSound(echo: true)
        case .fast:
            playSound(rate: 1.5)
        case .slow:
            playSound(rate: 0.5)
        case .reverb:
            playSound(reverb: true)
        }
    }
    
    @IBAction func stopPlayingAudio(_ sender: UIButton) {
        stopAudio()
    }

}
