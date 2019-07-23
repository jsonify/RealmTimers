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
    
    @IBOutlet weak var wakeView: UIView!
    // create outlet in the storyboard with type CountdownProgressBar

    @IBOutlet weak var countdownProgressBar: CountdownProgressBar!
    @IBOutlet weak var wakeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        // Do any additional setup after loading the view.

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
=======
        pfDurTime = preFireTime
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownDuration), userInfo: nil, repeats: true)
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
//            self.pfDurTime = self.pfDurTime - 1
//            self.pfDuration.text = "\(self.pfDurTime)"
//        })

        
        //try to use this to envoke a slight delay
//        self.perform(#selector(animateProgress), with: nil, afterDelay: 2.0)
        
//        let preFireSeconds = preFireTime
//        pfDuration.text = "\(preFireSeconds!)"
//        drawPreFireCircle1(color: UIColor.red)
        
    }
    
    func drawPreFireCircle1(color: UIColor) {
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 *  CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        // to change color of pfDuration
//        switch <#value#> {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
        
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(shapeLayer)
        drawCircle()
>>>>>>> parent of 4997beb... finished cleanup
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        countdownProgressBar.startCoundown(duration: preFireTime, showPulse: false)
//        createGradientView()
    }
    
    /// Creates gradient view
    
<<<<<<< HEAD
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
=======
    func drawCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = CFTimeInterval(preFireTime)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        shapeLayer.add(basicAnimation, forKey: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 10.0) {
            
        }
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
>>>>>>> parent of 4997beb... finished cleanup
    
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
