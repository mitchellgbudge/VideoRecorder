//
//  ViewController.swift
//  VideoRecorder
//
//  Created by Mitchell Budge on 7/10/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted == false {
                    fatalError("Please request user enable camera in Settings -> Privacy.")
                }
                DispatchQueue.main.async {
                    self.showCamera()
                }
            }
        case .restricted:
            fatalError("Please inform the user they cannot use the app due to parental restrictions.")
        case .denied:
            fatalError("Please request user to enable camera usage in Settings -> Privacy.")
        case .authorized:
            showCamera()
        }
    }

    private func showCamera() {
        performSegue(withIdentifier: "ShowCamera", sender: self)
    }

}

