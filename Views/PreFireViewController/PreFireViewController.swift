//
//  PreFireViewController.swift
//  RealmTimers
//
//  Created by Jason on 7/8/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import RealmSwift
import UIKit

class PreFireViewController: UIViewController {
    
    var timerPreFire = Timer()
    var timerDuration = Timer()
    var preFireTime: Int!
    var fireDuration = 0
    @IBOutlet weak var pfDuration: UILabel!
    let preFireDurationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.white
        return label
    }()
    var pfLabel: UILabel!
    var pfDurTime = 0 {
        didSet {
            pfDuration.text = "\(pfDurTime)\nseconds\nleft"
        }
    }
    
    var shapeLayer = CAShapeLayer()
    
    fileprivate func setupDurationLabel() {
        pfDuration.translatesAutoresizingMaskIntoConstraints = false
        pfDuration.textAlignment = .center
        pfDuration.lineBreakMode = .byWordWrapping
        pfDuration.numberOfLines = 0
        self.view.addSubview(pfDuration)
        
        pfDuration.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        pfDuration.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pfDuration.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pfDurTime = preFireTime
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDurationLabel()
        fireDuration = pfDurTime
        timerPreFire = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownDuration), userInfo: nil, repeats: true)
        drawPreFireCircle1(color: UIColor.red)
    }
    
    func drawPreFireCircle1(color: UIColor) {
        let centerPoint = view.center
        let circularPath = UIBezierPath(arcCenter: centerPoint, radius: view.frame.width / 2 - 50, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi - CGFloat.pi/2, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 50
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(shapeLayer)
        drawCircle()
    }
    
    @objc func countDownDuration() {
        pfDurTime = pfDurTime - 1
        pfDuration.text = "\(pfDurTime)\nseconds\nleft"
        if pfDurTime == (preFireTime - (preFireTime/4)) {
            shapeLayer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            view.backgroundColor = .red
        } else if pfDurTime == (preFireTime - (preFireTime/2)) {
            shapeLayer.strokeColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        } else if pfDurTime == (preFireTime - (preFireTime/2 + preFireTime/4)) {
            shapeLayer.strokeColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        }
        if pfDurTime == 0 {
            shapeLayer.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            pfDuration.text = "\(fireDuration)\nseconds\nleft"
            timerPreFire.invalidate()
            timerDuration = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTime), userInfo: nil, repeats: true)
        }
    }
    
    @objc func fireTime() {
        fireDuration = fireDuration - 1
        pfDuration.text = "\(fireDuration)\nseconds\nleft"
        if fireDuration == 0 {
            timerDuration.invalidate()
            dismiss(animated: true)
        }
    }
    
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
        timerPreFire.invalidate()
        dismiss(animated: true, completion: nil)
    }
    
}

