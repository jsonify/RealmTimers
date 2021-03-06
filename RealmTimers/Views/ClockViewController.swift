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

class ClockViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var soundIndicatorButton: SoundToggleButton!
    @IBOutlet weak var preFireVCButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var preFireTimeLabel: UILabel!
    @IBOutlet weak var fireTimeLabel: UILabel!

    #if DEVELOPMENT
    var multiplier = ClockStyle.debug.rawValue
    #else
    var multiplier = ClockStyle.seconds.rawValue
    #endif
    
    var timerIndexToEdit: Int?
    var timerTime = Date()
    var wakerTimer: Timer?
    var preFireStyle = ""
    var preFireDuration = 0
    var fireDuration = 0
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let gradient = CAGradientLayer()
    let colorOne = #colorLiteral(red: 0.007843137255, green: 0.05490196078, blue: 0.2078431373, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.01960784314, green: 0.1803921569, blue: 0.2078431373, alpha: 1).cgColor
    let colorThree = #colorLiteral(red: 0.1098039216, green: 0.05098039216, blue: 0.2078431373, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wakerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getTimerData), userInfo: nil, repeats: true)
        #if DEVELOPMENT
        preFireVCButton.isHidden = false
        #else
        preFireVCButton.isHidden = true
        #endif
        getTimerData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK:- Gradient Stuff
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createGradientView()
    }
    
    fileprivate func createGradientView() {
        gradientSet.append([colorOne, colorTwo])
        gradientSet.append([colorTwo, colorThree])
        gradientSet.append([colorThree, colorOne])
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        self.view.layer.insertSublayer(gradient, at: 0)
        animateGradient()
    }
    
    fileprivate func animateGradient() {
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 20.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientChangeAnimation.delegate = self
        gradient.add(gradientChangeAnimation, forKey: "gradientChangeAnimation")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
    
    // MARK:- Other Stuff
    
    @objc fileprivate func getTimerData() {
        let realm = try! Realm()
        let timer = realm.objects(TimerModel.self)
        
        if let index = timerIndexToEdit {
            timeLabel.text = formatTime(date: Date())
            timerTime = timer[index].timerTime
            fireTimeLabel.text = formatTime(date: timerTime)
            preFireStyle = timer[index].preFireStyle
            preFireDuration = Int(timer[index].preFireDuration)!
            let preFiredTime = timerTime - preFireDuration.minutes
            preFireTimeLabel.text = formatTime(date: preFiredTime)
            
            let now = Date()
            let formatter = DateFormatter()
            
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "hh:mm a"
            
            if formatter.string(from: preFiredTime) == formatter.string(from: now) {
                showPreFireVC()
                wakerTimer?.invalidate()
            }
        }
    }
    
    @IBAction func showPreFireTapped(_ sender: Any) {
        showPreFireVC()
    }
    
    func showPreFireVC() {
        switch preFireStyle {
        case "Math":
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MathPreFireViewController") as! MathPreFireViewController
            vc.preFireTime = preFireDuration * multiplier
            self.present(vc, animated: true)
        case "Circle":
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CirclePreFireViewController") as! CirclePreFireViewController
            vc.preFireTime = preFireDuration * multiplier
            self.present(vc, animated: true)
        case "Bars":
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BarsPreFireViewController") as! BarsPreFireViewController
            vc.preFireTime = preFireDuration * multiplier
            self.present(vc, animated: true)
        default:
            break
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        wakerTimer?.invalidate()
    }
    
    fileprivate func formatTime(date:Date) -> String {
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
