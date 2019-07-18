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

class PreFireViewController: UIViewController {
    
    var timer = Timer()
    var preFireTime: Int!
    @IBOutlet weak var pfDuration: UILabel!
    let preFireDurationLabel: UILabel = {
       let label = UILabel()
//        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.white
        return label
    }()
    var pfLabel: UILabel!
    var pfDurTime = 0 {
        didSet {
            pfDuration.text = "\(pfDurTime)"
        }
    }
    
    var shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    @objc func countDownDuration() {
        self.pfDurTime = self.pfDurTime - 1
        self.pfDuration.text = "\(self.pfDurTime)"
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
    
}

