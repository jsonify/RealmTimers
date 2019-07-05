//
//  AddTimerViewController.swift
//  RealmTimers
//
//  Created by Jason on 6/28/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class AddTimerViewController: UITableViewController {

//    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var fireTimePicker: UIDatePicker!
    var timer = TimerModel()
    
    @IBOutlet weak var preFireDurationSlider: UISlider!
    var preFireDuration = 0
    @IBOutlet weak var fireDurationSlider: UISlider!
    var fireDuration = 0
    
    var timerIndexToEdit: Int?
    
    var doneSaving: (() -> ())?
    var timerFunctions = TimerFunctions()
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingSliderValues()
        sectionLabel.textColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        
//        if let index = timerIndexToEdit {
//            
//        }
        
    }
    
    func setStartingSliderValues() {
        preFireDuration = Int(preFireDurationSlider.value) * 10
        fireDuration = Int(fireDurationSlider.value) * 10
    }
    
    @IBAction func changePreFire(_ sender: UISlider) {
        preFireDuration = Int(preFireDurationSlider.value) * 10
        print(preFireDuration)
    }
    @IBAction func changeFire(_ sender: UISlider) {
        fireDuration = Int(fireDurationSlider.value) * 10
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let currentDateTime = fireTimePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        timerFunctions.createTimer(timerModel: TimerModel(name: "\(dateFormatter.string(from: currentDateTime))", preFireDuration:
            "\(preFireDuration)", fireDuration: "\(fireDuration)"))
        if let doneSaving = doneSaving {
            doneSaving()
            
        }
        
        dismiss(animated: true)
    }
    
}
