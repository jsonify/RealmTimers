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
                showPreFireVC()
                // need to add timer that changes the hasFired as a bool for 1 minute
                // so that if someone clicks the X, the timer doesn't fire again
                
                wakerTimer?.invalidate()
            }
        }
    }
    
    @IBAction func showPreFireTapped(_ sender: Any) {
        showPreFireVC()
    }
    
    func showPreFireVC() {
        let preFireVC = self.storyboard?.instantiateViewController(withIdentifier: "boom") as! PreFireViewController
//        print(preFireDuration)
        
        // when tapping the button that calls this method,
        // inject the variable preFireTime in the CountdownProgressBar class
        // with the preFireDuration
        
        preFireVC.preFireTime = preFireDuration
        self.present(preFireVC, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        wakerTimer?.invalidate()
    }
    
    func formatTime(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
