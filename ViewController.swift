//
//  ViewController.swift
//  VideoRecorder
//
//  Created by Mitchell Budge on 7/10/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCamera()
    }

    private func showCamera() {
        performSegue(withIdentifier: "ShowCamera", sender: self)
    }

}

