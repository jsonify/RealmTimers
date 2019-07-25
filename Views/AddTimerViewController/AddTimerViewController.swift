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

//    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var fireTimePicker: UIDatePicker!
    
    @IBOutlet var preFireDurationButtons: [UIButton]!
    
    var timer = TimerModel()
    
    @IBOutlet weak var preFireDurationSlider: UISlider!
    var preFireDuration = 0
    
    @IBOutlet weak var tempTimeLabel: UILabel!
    //    var timerIndexToEdit: Int?
    
    var doneSaving: (() -> ())?
    var timerFunctions = TimerFunctions()
    
    var timerModel: Results<TimerModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStartingSliderValues()
        self.hideKeyboardWhenTappedAround()
    
        fireTimePicker.setDate(NSDate(timeIntervalSinceNow: 60) as Date, animated: false)
        fireTimePicker.setValue(UIColor.white, forKeyPath: "textColor")
        fireTimePicker.setValue(0.7, forKeyPath: "alpha")
        
        /* TODO: V2.1 Future feature that allows to edit timer
         Issue: Currently, I'm not able to get the info from the
         Realm object, even though I've added a dateFormatter
         and called the object at the index that I need.
        */
//        if let index = timerIndexToEdit {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "hh:mm a"
//
//
//            let timer = timerModel?[index]
////            fireTimePicker.setDate(dateFormatter.date(from: timer?.name ?? "7:00 am") ?? Date(), animated: true)
//            preFireDurationSlider.setValue((timer?.preFireDuration as! NSString).floatValue, animated: true)
//        }
    }
    
    @IBAction func preFireDurationSelected(_ sender: UIButton) {
        preFireDurationButtons.forEach({ $0.tintColor = Theme.darkBlueColor })
        
        sender.tintColor = Theme.pinkTintColor
    }
    
    func setStartingSliderValues() {
        preFireDuration = Int(preFireDurationSlider.value) * 10
    }
    
    @IBAction func changePreFire(_ sender: UISlider) {
        preFireDuration = Int(preFireDurationSlider.value)
        tempTimeLabel.text = "\(preFireDuration)"
    }

    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let currentDateTime = fireTimePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let preFireAmount: PreFireDuration = getSelectedPreFireDuration()
        //TODO:- translate preFireAmount into an actual duration
        preFireDuration = preFireAmount.hashValue
        print(preFireDuration)
        timerFunctions.createTimer(timerModel: TimerModel(name: currentDateTime, preFireDuration:
                    "\(preFireDuration)"))
        if let doneSaving = doneSaving {
            doneSaving()
        }
        
        dismiss(animated: true)
    }
    
    func getSelectedPreFireDuration() -> PreFireDuration {
        for (index, button) in preFireDurationButtons.enumerated() {
            // TODO:- use sender.tag to identify the button
            if button.tintColor == Theme.pinkTintColor {
                return PreFireDuration(rawValue: index + 1) ?? .q2
            }
        }
        
        return .q2
    }
    
}
