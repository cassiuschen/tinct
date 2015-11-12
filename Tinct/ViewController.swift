//
//  ViewController.swift
//  Tinct
//
//  Created by Cassius Chen on 11/10/15.
//  Copyright © 2015 Cassius Chen. All rights reserved.
//

import UIKit
import EZAudio

class ViewController: UIViewController, EZMicrophoneDelegate {

    var microphone : EZMicrophone!
    var isRecording = false
    
    
    @IBOutlet var recordGL: EZAudioPlotGL!
    @IBOutlet var recordBtn: UIButton!
    @IBAction func onPressRecordBtn(sender: AnyObject) {
        self.microphone.startFetchingAudio()
        print("Record Start")
        self.isRecording = true
    }
    @IBAction func offPressRecordBtn(sender: AnyObject) {
        self.microphone.stopFetchingAudio()
        print("Record Stop")
        self.isRecording = false
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPlotStyle()
        self.microphone = EZMicrophone(delegate: self, startsImmediately: true)
        self.microphone.device = EZAudioDevice.currentInputDevice()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        setBgImg()
        self.view.addSubview(self.recordGL)
        self.view.addSubview(self.recordBtn)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBgImg() {
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        let gradientLayer = CAGradientLayer()
        gradientLayer.bounds = UIScreen.mainScreen().bounds
        gradientLayer.frame = UIScreen.mainScreen().bounds
        gradientLayer.colors = [UIColor(red: 251/255.0, green: 221/255.0, blue: 135/255.0, alpha: 1).CGColor, UIColor(red: 247/255.0, green: 206/255.0, blue: 91/255.0, alpha: 1).CGColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.setNeedsDisplay()
        self.view.layer.addSublayer(gradientLayer)
    }
    
    func setPlotStyle() {
        self.recordGL.plotType = EZPlotType(rawValue: 1)!
        self.recordGL.backgroundColor = UIColor(white: 0/255, alpha: 0)
        self.recordGL.shouldFill = true
        self.recordGL.shouldMirror = false
        
        /*
        let inputFormat : AudioStreamBasicDescription = EZAudioUtilities.monoFloatFormatWithSampleRate(self.RATE)
        self.output = EZOutput(dataSource: self, inputFormat: inputFormat)
        self.output.delegate = self
*/
    }
    /*
    func output(output: EZOutput!, shouldFillAudioBufferList audioBufferList: UnsafeMutablePointer<AudioBufferList>, withNumberOfFrames frames: UInt32, timestamp: UnsafePointer<AudioTimeStamp>) -> OSStatus {
        var safeAudioBufferList = UnsafeMutableAudioBufferListPointer(audioBufferList)
        for bufferList in safeAudioBufferList {
            var theta = self.theta
            var frequency = self.frequency
            var thetaIncrement = 2.0 * M_PI * frequency / (self.RATE as! Double)
            bufferList.mData = self.amplitude * EZAudioUtilities.SGN(theta as! Float)
            theta += thetaIncrement
            if theta > 2.0 * M_PI {
                theta -= 4.0 * M_PI
            }
            self.theta = theta
            
        }
        return noErr
    }
*/
    
    
    
    func microphone(microphone: EZMicrophone!, hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            self.recordGL.updateBuffer(buffer[0], withBufferSize: bufferSize)
            //NSLog(buffer[0])
        })
    }
    
    
}

