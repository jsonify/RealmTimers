//
//  ClockViewController.swift
//  RealmTimers
//
//  Created by Jason on 6/27/19.
//  Copyright © 2019 Jason. All rights reserved.
//
import RealmSwift
import UIKit

class ClockViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timerIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentTime()
        
        let realm = try! Realm()
        let timer = realm.objects(TimerModel.self)
        
        if let index = timerIndexToEdit {
            let currentTimer = timer[index]
            print(currentTimer.name)
        }
    }
    
    func getCurrentTime() {
        let currentDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        timeLabel.text = "\(dateFormatter.string(from: currentDateTime))"
    }
}
