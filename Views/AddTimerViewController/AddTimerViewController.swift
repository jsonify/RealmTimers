//
//  AddTimerViewController.swift
//  RealmTimers
//
//  Created by Jason on 6/28/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import RealmSwift
import UIKit

class AddTimerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var customSegmentedController: CustomSegmentedControl!
    @IBOutlet weak var preFireStyleSegmentedController: CustomSegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var fireTimePicker: UIDatePicker!
    @IBOutlet weak var preFireDurationSegment: UISegmentedControl!
    @IBOutlet var preFireDurationButtons: [UIButton]!
    @IBOutlet var menuButtons: [UIButton]!
    
    @IBOutlet var menuItemView: [UIView]!
    
    var timer = TimerModel()
    var doneSaving: (() -> ())?
    var timerFunctions = TimerFunctions()
    var timerModel: Results<TimerModel>?
    var preFireStyle = "Bars"
    
    var preFireDuration = 15
    var timerName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        nameTextField.delegate = self
        configureTimePicker()
        for button in menuButtons {
            button.addShadowAndRoundedCorners()
        }
        for item in menuItemView {
            item.addShadowAndRoundedCorners()
            
        }
    }
    
    fileprivate func configureTimePicker() {
        fireTimePicker.setDate(NSDate(timeIntervalSinceNow: 60) as Date, animated: false)
        fireTimePicker.setValue(UIColor.white, forKeyPath: "textColor")
        fireTimePicker.setValue(0.7, forKeyPath: "alpha")
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
//        print("\(String(describing: nameTextField.text))")
        let currentDateTime = fireTimePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        if nameTextField.text!.isEmpty {
            timerName = "New Timer"
        } else {
            timerName = nameTextField.text
        }
//        let preFireAmount = getSelectedPreFireDuration()
        
        timerFunctions.createTimer(timerModel: TimerModel(timerName: timerName, timerTime: currentDateTime, preFireDuration: "\(preFireDuration)", preFireStyle: preFireStyle))
        if let doneSaving = doneSaving {
            doneSaving()
        }
        
        dismiss(animated: true)
    }
    
    @IBAction func preFireDurationSegmentIndexChanged(_ sender: UISegmentedControl) {
    }
    
    @IBAction func preFireStyleSegmentSelected(_ sender: CustomSegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            preFireStyle = "Bars"
        case 1:
            preFireStyle = "Math"
        case 2:
            preFireStyle = "Circle"
        default:
            break
        }
    }
    
    @IBAction func wtf(_ sender: CustomSegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            preFireDuration = 15
        case 1:
            preFireDuration = 30
        case 2:
            preFireDuration = 45
        case 3:
            preFireDuration = 60
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}

extension UITextField{
    @IBInspectable var placeholderColor: UIColor {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .lightText
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: newValue])
        }
    }
}


