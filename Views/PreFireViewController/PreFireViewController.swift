//
//  PreFireViewController.swift
//  RealmTimers
//
//  Created by Jason on 7/18/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class PreFireViewController: UIViewController, CAAnimationDelegate {
    var preFireTime: Int!
    var fireNow = false
    
    // create outlet in the storyboard with type CountdownProgressBar

    @IBOutlet weak var countdownProgressBar: CountdownProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    func sayHello() {
        //TODO: get the background green
        view.backgroundColor = UIColor.green
        print("timer done")
    }

    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        countdownProgressBar.startCoundown(duration: preFireTime, showPulse: false)
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
