//
//  PreFireViewController.swift
//  RealmTimers
//
//  Created by Jason on 7/18/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

enum ClockStyle: Int {
    case seconds = 60
    case debug = 1
}

class PreFireViewController: UIViewController, CAAnimationDelegate {
    var preFireTime: Int!
    var fireNow = false
    
    private var timer = Timer()
    var duration = 0
    private var remainingTime = 0
    var showPulse = false
    
    var multiplier = ClockStyle.debug.rawValue
    
    @IBOutlet weak var wakeView: UIView!
    // create outlet in the storyboard with type CountdownProgressBar

    @IBOutlet weak var countdownProgressBar: CountdownProgressBar!
    @IBOutlet weak var wakeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    @objc private func handleTimerTick() {
        remainingTime -= 1
        if remainingTime > 0 {
            if remainingTime == (duration - duration/4) {
//                backgroundLayer.strokeColor = UIColor.blue.cgColor
            } else if remainingTime == (duration - duration/2) {
//                backgroundLayer.strokeColor = UIColor.yellow.cgColor
            } else if remainingTime == (duration - (duration/2 + duration/4)) {
//                backgroundLayer.strokeColor = UIColor.green.cgColor
            }
        } else {
            remainingTime = 0
            timer.invalidate()
//            removeTimerLayers()
//            preFireVC.sayHello()
        }
        
        DispatchQueue.main.async {
            self.countdownProgressBar.remainingTimeLabel.text = "\(self.remainingTime)"
        }
    }
    
    func startCoundown(duration: Int, showPulse: Bool = false) {
        self.duration = duration * multiplier
        self.showPulse = showPulse
        remainingTime = duration * multiplier
        countdownProgressBar.remainingTimeLabel.text = "\(remainingTime)"
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimerTick), userInfo: nil, repeats: true)
        countdownProgressBar.beginAnimation(showPulse: showPulse)
        
    }
    
    func sayHello() {
        print("method called")
//        if wakeView == nil {
//            print("this is nil")
//        }
//        wakeView?.backgroundColor = UIColor.green
//        wakeImageView.backgroundColor = UIColor.green
    }

    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startCoundown(duration: preFireTime, showPulse: false)
//        createGradientView()
    }
    
    /// Creates gradient view
    
//    func createGradientView() {
//
//        // overlap the colors and make it 3 sets of colors
//        gradientSet.append([colorOne, colorTwo])
//        gradientSet.append([colorTwo, colorThree])
//        gradientSet.append([colorThree, colorOne])
//
//        // set the gradient size to be the entire screen
//        gradient.frame = self.view.bounds
//        gradient.colors = gradientSet[currentGradient]
//        gradient.startPoint = CGPoint(x:0, y:0)
//        gradient.endPoint = CGPoint(x:1, y:1)
//        gradient.drawsAsynchronously = true
//
//        self.view.layer.insertSublayer(gradient, at: 0)
//
//        animateGradient()
//    }
    
//    @objc func handleTap() {
//        print("Tapped")
//
//        countdownProgressBar.startCoundown(duration: preFireTime, showPulse: true)
//    }
//
//    func animateGradient() {
//        // cycle through all the colors, feel free to add more to the set
//        if currentGradient < gradientSet.count - 1 {
//            currentGradient += 1
//        } else {
//            currentGradient = 0
//        }
//
//        // animate over 3 seconds
//        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
//        gradientChangeAnimation.duration = 3.0
//        gradientChangeAnimation.toValue = gradientSet[currentGradient]
//        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
//        gradientChangeAnimation.isRemovedOnCompletion = false
//        gradientChangeAnimation.delegate = self
//        gradient.add(gradientChangeAnimation, forKey: "gradientChangeAnimation")
//    }
//
//    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//
//        // if our gradient animation ended animating, restart the animation by changing the color set
//        if flag {
//            gradient.colors = gradientSet[currentGradient]
//            animateGradient()
//        }
//    }
}
