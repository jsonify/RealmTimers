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
    var wakerTimer: Timer?
    
    var preFireDuration = 0
    var fireDuration = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeLabel.text = formatTime(date: Date())
        getTimerData()
        wakerTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(getTimerData), userInfo: nil, repeats: true)
        delayWithSeconds(5) {
            print("This in the function")
        }
    }
    
    @objc func getTimerData() {
        let realm = try! Realm()
        let timer = realm.objects(TimerModel.self)
        
        if let index = timerIndexToEdit {
            timerTime = timer[index].name
            preFireDuration = Int(timer[index].preFireDuration)!
            fireDuration = Int(timer[index].fireDuration)!
//            print(formatTime(date: timerTime))
            let preFiredTime = timerTime - preFireDuration.minutes
            print(formatTime(date: preFiredTime))
            //show what time the preFire will execute
            preFireTimeLabel.text = formatTime(date: preFiredTime)
            let fakePre = formatTime(date: Date() + 6.minutes)
            
            print(fakePre)
            if fakePre == formatTime(date: preFiredTime) {
                print("Yes, fake.")
            }
            if formatTime(date: preFiredTime) == formatTime(date: Date()) {
                print("it worked")
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        wakerTimer?.invalidate()
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: timerTime) {
            print("Hello there.")
        }
    }
    
    func formatTime(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
