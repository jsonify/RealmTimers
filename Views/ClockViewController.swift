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
    @IBOutlet weak var fireTimeLabel: UILabel!
    
    var hasFired = false
    var timerIndexToEdit: Int?
    var timerTime = Date()
    var wakerTimer: Timer?
    
    var preFireDuration = 0
    var fireDuration = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getTimerData()
        wakerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getTimerData), userInfo: nil, repeats: true)
    }
    
    @objc func getTimerData() {
        let realm = try! Realm()
        let timer = realm.objects(TimerModel.self)
        
        if let index = timerIndexToEdit {
            timeLabel.text = formatTime(date: Date())
            timerTime = timer[index].name
            fireTimeLabel.text = formatTime(date: timerTime)
            
            // PreFire Work
            preFireDuration = Int(timer[index].preFireDuration)!
            let preFiredTime = timerTime - preFireDuration.minutes
            preFireTimeLabel.text = formatTime(date: preFiredTime)
            
            let now = Date()
            let formatter = DateFormatter()
            
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "hh:mm a"
            
            if formatter.string(from: preFiredTime) == formatter.string(from: now) && !hasFired {
                // show wake prefire sequence
                print("it worked")
                wakerTimer?.invalidate()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        wakerTimer?.invalidate()
    }
    
    func formatTime(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

extension Date {
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    func addSeconds(_ seconds: Int) -> Date {
        let seconds: TimeInterval = Double(seconds)
        let newDate: Date = self.addingTimeInterval(seconds)
        return newDate
    }
    
    func addMinutes(_ minutes: Int) -> Date {
        let seconds: TimeInterval = Double(minutes) * 60
        let newDate: Date = self.addingTimeInterval(seconds)
        return newDate
    }
    
}
