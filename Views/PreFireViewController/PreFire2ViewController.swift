//
//  PreFireViewController.swift
//  RealmTimers
//
//  Created by Jason on 7/8/19.
//  Copyright © 2019 Jason. All rights reserved.
//
import MBCircularProgressBar
import RealmSwift
import UIKit

enum ClockStyle: Int {
    case seconds = 60
    case debug = 1
}

class PreFire2ViewController: UIViewController {
    
    @IBOutlet weak var pfDuration: UILabel!

    var timer = Timer()
    var preFireTime: Int!
    var multiplier = ClockStyle.seconds.rawValue
    var shapeLayer = CAShapeLayer()
    var pfDurTime = 0 {
        didSet {
            pfDuration.text = "\(pfDurTime * multiplier)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pfDurTime = preFireTime
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownDuration), userInfo: nil, repeats: true)
        
        //try to use this to envoke a slight delay
//        self.perform(#selector(animateProgress), with: nil, afterDelay: 2.0)

        drawPreFireCircle1(color: UIColor.red)
        
    }
    
    func drawPreFireCircle1(color: UIColor) {
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)
//        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(shapeLayer)
        drawCircle()
    }
    
    @objc func countDownDuration() {
        pfDurTime = pfDurTime - 1
        pfDuration.text = "\(pfDurTime)"
        if pfDurTime == 0 {
            pfDuration.text = "End"
            timer.invalidate()
        }
    }
    
    //fix timing to match label
    
    func drawCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = CFTimeInterval(preFireTime)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shapeLayer.add(basicAnimation, forKey: nil)
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

