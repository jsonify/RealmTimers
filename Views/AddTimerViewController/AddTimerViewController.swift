//
//  AddTimerViewController.swift
//  RealmTimers
//
//  Created by Jason on 6/28/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import RealmSwift
import UIKit

class AddTimerViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var fireTimePicker: UIDatePicker!
    @IBOutlet weak var preFireDurationSegment: UISegmentedControl!
    @IBOutlet var preFireDurationButtons: [UIButton]!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var menuItemView: [UIView]!
    
    var timer = TimerModel()
    var doneSaving: (() -> ())?
    var timerFunctions = TimerFunctions()
    var timerModel: Results<TimerModel>?
    var preFireStyle = "Math"
    
    var preFireDuration = 0
    var timerName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configureTimePicker()
        for item in menuItemView {
            item.addShadowAndRoundedCorners()
            
        }
    }
    
    fileprivate func configureTimePicker() {
        fireTimePicker.setDate(NSDate(timeIntervalSinceNow: 60) as Date, animated: false)
        fireTimePicker.setValue(UIColor.white, forKeyPath: "textColor")
        fireTimePicker.setValue(0.7, forKeyPath: "alpha")
    }
    
    @IBAction func preFireDurationSelected(_ sender: UIButton) {
        preFireDurationButtons.forEach({ $0.tintColor = UIColor.darkGray })
        
        sender.tintColor = Theme.primaryColor
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
        let preFireAmount = getSelectedPreFireDuration()
        timerFunctions.createTimer(timerModel: TimerModel(timerName: timerName, timerTime: currentDateTime, preFireDuration: "\(preFireAmount)", preFireStyle: preFireStyle))
//        timerFunctions.createTimer(timerModel: TimerModel(timerName: timerName, timerTime: currentDateTime, preFireDuration: "\(preFireAmount)"))
        if let doneSaving = doneSaving {
            doneSaving()
        }
        
        dismiss(animated: true)
    }
    
    func getSelectedPreFireDuration() -> Int {
        for (_, button) in preFireDurationButtons.enumerated() {
            if button.tintColor == Theme.primaryColor {
                return button.tag
            } else {
                button.tintColor = .darkGray
            }
        }
        return 30
    }
    
    @IBAction func preFireDurationSegmentIndexChanged(_ sender: UISegmentedControl) {
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
