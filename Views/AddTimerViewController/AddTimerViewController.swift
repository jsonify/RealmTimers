//
//  AddTimerViewController.swift
//  RealmTimers
//
//  Created by Jason on 6/28/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class AddTimerViewController: UIViewController {

//    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var doneSaving: (() -> ())?
    var timerFunctions = TimerFunctions()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.textColor = UIColor.white
        
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        timerFunctions.createTimer(timerModel: TimerModel(name: timerTextField.text!, preFireDuration: 0, fireDuration: 19))
        if let doneSaving = doneSaving {
            doneSaving()
            
        }
        dismiss(animated: true)
    }
    
}
