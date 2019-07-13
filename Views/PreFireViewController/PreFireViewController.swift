//
//  PreFireViewController.swift
//  RealmTimers
//
//  Created by Jason on 7/8/19.
//  Copyright © 2019 Jason. All rights reserved.
//
import MBCircularProgressBar
import UIKit

class PreFireViewController: UIViewController {
    
//    circle progress indicator
//   https://www.youtube.com/watch?v=aylHkGVg-P4
    @IBOutlet weak var progressView: MBCircularProgressBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.progressView.value = 0
        // get the preFire time
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 10.0) {
            self.progressView.value = 60
            if self.progressView.value == 30 {
                self.progressView.progressColor = UIColor.green
            }
        }
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

