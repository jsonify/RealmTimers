//
//  ClockViewController.swift
//  RealmTimers
//
//  Created by Jason on 6/27/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import AVFoundation
import SwiftDate
import RealmSwift
import UIKit

class ClockViewController: UIViewController, CAAnimationDelegate {
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
    var multiplier = ClockStyle.seconds.rawValue
    
    let gradient = CAGradientLayer()
    // list of array holding 2 colors
    var gradientSet = [[CGColor]]()
    // current gradient index
    var currentGradient: Int = 0
    
    // colors to be added to the set
    let colorOne = #colorLiteral(red: 0.007843137255, green: 0.05490196078, blue: 0.2078431373, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.01960784314, green: 0.1803921569, blue: 0.2078431373, alpha: 1).cgColor
    let colorThree = #colorLiteral(red: 0.1098039216, green: 0.05098039216, blue: 0.2078431373, alpha: 1).cgColor
//    let colorOne = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
//    let colorTwo = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
//    let colorThree = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTimerData()
        wakerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getTimerData), userInfo: nil, repeats: true)
        Sound.shared.startSound()
    }
    
    // MARK:- Gradient Stuff
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createGradientView()
    }
    
    /// Creates gradient view
    
    func createGradientView() {
        
        // overlap the colors and make it 3 sets of colors
        gradientSet.append([colorOne, colorTwo])
        gradientSet.append([colorTwo, colorThree])
        gradientSet.append([colorThree, colorOne])
        
        // set the gradient size to be the entire screen
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        animateGradient()
    }
    
    func animateGradient() {
        // cycle through all the colors, feel free to add more to the set
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        // animate over 3 seconds
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 20.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientChangeAnimation.delegate = self
        gradient.add(gradientChangeAnimation, forKey: "gradientChangeAnimation")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        // if our gradient animation ended animating, restart the animation by changing the color set
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
    
    // MARK:- Other Stuff
    
    @objc func getTimerData() {
        let realm = try! Realm()
        let timer = realm.objects(TimerModel.self)
        
        if let index = timerIndexToEdit {
            timeLabel.text = formatTime(date: Date())
            timerTime = timer[index].timerTime
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
//        showTestVC()
    }
    
    func showTestVC() {
        let testVC = self.storyboard?.instantiateViewController(withIdentifier: "test") as! TestingViewController
        testVC.preFireTime = preFireDuration * multiplier
        self.present(testVC, animated: true)
    }
    
    func showPreFireVC() {
        let preFireVC = self.storyboard?.instantiateViewController(withIdentifier: "boom") as! PreFireViewController
        preFireVC.preFireTime = preFireDuration * multiplier
        self.present(preFireVC, animated: true)
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
        Sound.shared.stopSound()
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
