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
    @IBOutlet weak var preFireTimeLabel: UILabel!
    
    var timerIndexToEdit: Int?
    var timerTime = Date()
    var preFireDuration = 0
    var fireDuration = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeLabel.text = formatTime(date: Date())
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
            timerTime = timer[index].name
            preFireDuration = Int(timer[index].preFireDuration)!
            fireDuration = Int(timer[index].fireDuration)!
//            print(formatTime(date: timerTime))
            let preFiredTime = timerTime - preFireDuration.minutes
            print(formatTime(date: preFiredTime))
            //show what time the preFire will execute
            preFireTimeLabel.text = formatTime(date: preFiredTime)
            //
        }
    }
    
    func formatTime(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
