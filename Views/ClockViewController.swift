//
//  ClockViewController.swift
//  RealmTimers
//
//  Created by Jason on 6/27/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import SwiftDate
import RealmSwift
import UIKit

class ClockViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timerIndexToEdit: Int?
    var timerTime = Date()
    var preFireDuration = 0
    var fireDuration = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentTime()
        getTimerData()
        
    }
    
    func getTimerData() {
        let realm = try! Realm()
        let timer = realm.objects(TimerModel.self)
        
        if let index = timerIndexToEdit {
//            let currentTimer = timer[index].name
//            let time = DateInRegion(components: {
//                $0.hour = currentTimer?.hour
//                $0.minute = currentTimer?.minute
//            })
            preFireDuration = Int(timer[index].preFireDuration)!
            fireDuration = Int(timer[index].fireDuration)!
//            print(time)
        }
    }
    
    func getCurrentTime() {
        let currentDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        timeLabel.text = "\(dateFormatter.string(from: currentDateTime))"
    }
}
