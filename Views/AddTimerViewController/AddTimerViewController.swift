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
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var fireTimePicker: UIDatePicker!
    @IBOutlet weak var preFireDurationTextField: UITextField!
    @IBOutlet weak var fireDurationTextField: UITextField!
    
    var doneSaving: (() -> ())?
    var timerFunctions = TimerFunctions()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionLabel.textColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let currentDateTime = fireTimePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        timerFunctions.createTimer(timerModel: TimerModel(name: "\(dateFormatter.string(from: currentDateTime))", preFireDuration: preFireDurationTextField!.text ?? "0", fireDuration: fireDurationTextField!.text ?? "0"))
        if let doneSaving = doneSaving {
            doneSaving()
            
        }
        print(fireDurationTextField!.text)
        dismiss(animated: true)
    }
    
}
