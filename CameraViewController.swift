//
//  CameraViewController.swift
//  VideoRecorder
//
//  Created by Mitchell Budge on 7/10/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    lazy private var captureSession = AVCaptureSession()
    lazy private var fileOutput = AVCaptureMovieFileOutput()
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var cameraView: CameraPreviewView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = bestCamera()
        guard let cameraInput = try? AVCaptureDeviceInput(device: camera) else {
            fatalError()
        }
        if captureSession.canAddInput(cameraInput) {
            captureSession.addInput(cameraInput)
        }
        
        if captureSession.canAddOutput(fileOutput) {
            captureSession.addOutput(fileOutput)
        }
        
        if captureSession.canSetSessionPreset(.hd1920x1080) {
            captureSession.canSetSessionPreset(.hd1920x1080)
        }
        
        captureSession.commitConfiguration()
        
        cameraView.session = captureSession
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession.stopRunning()
    }
    
    private func bestCamera() -> AVCaptureDevice {
        if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
            return device
        }
        
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            return device
        }
        
        fatalError("No cameras exist - you're probably running on the simulator")
    }
    
    func newRecordingURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let name = "movie"
        let url = documentsDirectory.appendingPathComponent(name).appendingPathExtension("mov")
        print("URL: \(url)")
        return url
    }
    
    func updateViews() {
        if fileOutput.isRecording {
            recordButton.setImage(UIImage(named: "Stop"), for: .normal)
            recordButton.tintColor = UIColor.black
        } else {
            recordButton.setImage(UIImage(named: "Record"), for: .normal)
            recordButton.tintColor = UIColor.red
        }
    }
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        print("Record")
        
        if fileOutput.isRecording {
            fileOutput.stopRecording()
        } else {
            fileOutput.startRecording(to: newRecordingURL(), recordingDelegate: self)
        }
    }
    
}

extension CameraViewController: AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        updateViews()
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        updateViews()
    }
}
