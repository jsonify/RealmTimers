//
//  BarsPreFireViewController.swift
//  RealmTimers
//
//  Created by Jason Rueckert on 8/27/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class BarsPreFireViewController: UIViewController {
    
    var preFireTime: Int!
    var duration: Double!
    var timerPreFire = Timer()
    var timerDuration = Timer()
    var fireDuration = 0
    var pfDurationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    var pfLabel: UILabel!
    var pfDurTime = 0 {
        didSet {
            pfDurationLabel.text = "\(pfDurTime)"
        }
    }
    
    var characterPicked = false
    
    var barWave = 1
    var bars = [MyCustomView]()
//    var bar1 = MyCustomView()
//    var bar2 = MyCustomView()
//    var bar3 = MyCustomView()
    
    let presentImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "present"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showButtons()
        duration = Double(preFireTime/12)
        
        drawPreFireBars1(color: .red, duration: duration)
        showLabel()
        fireDuration = pfDurTime
        timerPreFire = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownDuration), userInfo: nil, repeats: true)
    }
    
    func drawPreFireBars1(color: UIColor, duration: Double) {
        let barWidth = view.frame.size.width/3
        let barHeight = view.frame.size.height

        let bar1 = MyCustomView(frame: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
        bar1.backgroundColor = .red

        bars.append(bar1)

        let bar2 = MyCustomView(frame: CGRect(x: barWidth, y: 0, width: barWidth, height: barHeight))
        bar2.backgroundColor = .red
        bars.append(bar2)

        let bar3 = MyCustomView(frame: CGRect(x: barWidth * 2, y: 0, width: barWidth, height: barHeight))
        bar3.backgroundColor = .red
        bars.append(bar3)

        for bar in bars {
            setAnchorPoint(anchorPoint: CGPoint(x: 0, y: 0), forView: bar)
            self.view.addSubview(bar)
        }
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration) {
                UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
                    self.bars[0].transform = CGAffineTransform(translationX: 0, y: self.bars[0].frame.size.height)
                })
            }
            UIView.addKeyframe(withRelativeStartTime: duration, relativeDuration: duration) {
                UIView.animate(withDuration: duration, delay: duration, options: .curveLinear, animations: {
                    self.bars[1].transform = CGAffineTransform(translationX: 0, y: self.bars[1].frame.size.height)
                })
            }
            UIView.addKeyframe(withRelativeStartTime: duration * 2, relativeDuration: duration) {
                UIView.animate(withDuration: duration, delay: duration * 2, options: .curveLinear, animations: {
                    self.bars[2].transform = CGAffineTransform(translationX: 0, y: self.bars[2].frame.size.height)
                })
            }
        })

    }
    
    func showLabel() {
        pfDurationLabel = UILabel(frame: CGRect(x: 0, y: 50, width: 400, height: 50))
        //        pfDurationLabel.text = title
        pfDurationLabel.textAlignment = .center
        pfDurationLabel.font = UIFont(name: "Avenir", size: 25)
        self.view.addSubview(pfDurationLabel)
        pfDurTime = preFireTime
    }
    func showButtons() {
        let closeViewButton: UIButton = UIButton(frame: CGRect(x: view.frame.size.width - 110, y: view.frame.size.height - 100, width: 100, height: 50))
        closeViewButton.layer.cornerRadius = 10
        closeViewButton.backgroundColor = .green
        closeViewButton.setTitle("Done", for: .normal)
        closeViewButton.addTarget(self, action:#selector(closeView), for: .touchUpInside)
        self.view.addSubview(closeViewButton)
    }
    
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func scaleBarsUp(_ duration: Double) {

//        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration) {
//                UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
//                    self.bars[0].transform = CGAffineTransform(translationX: 0, y: self.bars[0].frame.size.height)
//                })
//            }
//            UIView.addKeyframe(withRelativeStartTime: duration, relativeDuration: duration) {
//                UIView.animate(withDuration: duration, delay: duration, options: .curveLinear, animations: {
//                    self.bars[1].transform = CGAffineTransform(translationX: 0, y: self.bars[1].frame.size.height)
//                })
//            }
//            UIView.addKeyframe(withRelativeStartTime: duration * 2, relativeDuration: duration) {
//                UIView.animate(withDuration: duration, delay: duration * 2, options: .curveLinear, animations: {
//                    self.bars[2].transform = CGAffineTransform(translationX: 0, y: self.bars[2].frame.size.height)
//                })
//            }
//        })
    }
    
    @objc func countDownDuration() {
        pfDurTime = pfDurTime - 1
        pfDurationLabel.text = "\(pfDurTime)"
        
        
//        scaleBarsUp(duration)
        
        
//        UIView.animate(withDuration: 15, delay: 0, options: .curveLinear, animations: {
//            self.bars[0].transform = CGAffineTransform(scaleX: 0, y: 0.01)
////            self.bars[0].transform = CGAffineTransform(translationX: 0, y: self.bars[0].frame.size.height)
//        }) { (finished) in
//            if finished {
//                UIView.animate(withDuration: duration, delay: duration, options: .curveLinear, animations: {
//                    self.bars[1].transform = CGAffineTransform(translationX: 0, y: self.bars[1].frame.size.height)
//                }) { (finished) in
//                    if finished {
//                        UIView.animate(withDuration: duration, delay: duration * 2, options: .curveLinear, animations: {
//                            self.bars[2].transform = CGAffineTransform(translationX: 0, y: self.bars[2].frame.size.height)
//                        }) { (finished) in
//                            if finished {
//                                print("Done")
//                            }
//                        }
//                    }
//                }
//            }
//        }
        
//        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration) {
//                UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
//                    self.bars[0].transform = CGAffineTransform(translationX: 0, y: self.bars[0].frame.size.height)
//                })
//            }
//            UIView.addKeyframe(withRelativeStartTime: duration, relativeDuration: duration) {
//                UIView.animate(withDuration: duration, delay: duration, options: .curveLinear, animations: {
//                    self.bars[1].transform = CGAffineTransform(translationX: 0, y: self.bars[1].frame.size.height)
//                })
//            }
//            UIView.addKeyframe(withRelativeStartTime: duration * 2, relativeDuration: duration) {
//                UIView.animate(withDuration: duration, delay: duration * 2, options: .curveLinear, animations: {
//                    self.bars[2].transform = CGAffineTransform(translationX: 0, y: self.bars[2].frame.size.height)
//                })
//            }
//        })

//        if pfDurTime == (preFireTime - (preFireTime/4)) {
//            print("1/4 done")
//            UIView.animate(withDuration: 3, animations: {
//                self.bar1.frame.size.height = 0.01
//            }) { _ in
//                self.bar1.removeFromSuperview()
//            }
//            shapeLayer1.position = CGPoint(x: 0, y: 0)
//            shapeLayer1.anchorPoint = CGPoint(x: 0, y: 0.5)
//            let layerAnimation = CABasicAnimation(keyPath: "bounds.size.height")
//            layerAnimation.duration = 2
//            layerAnimation.fromValue = 0
//            layerAnimation.toValue = 0
//            shapeLayer1.add(layerAnimation, forKey: "anim")
//            shapeLayer1.strokeColor = #colorLiteral(red: 0.7568627596, green: 0.6892270425, blue: 0.2031356938, alpha: 1)
//            view.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.3803921569, blue: 0.8901960784, alpha: 1)
//        } else if pfDurTime == (preFireTime - (preFireTime/2)) {
//            //            shapeLayer.strokeColor = #colorLiteral(red: 0.07886815806, green: 0.8549019694, blue: 0.7889860416, alpha: 1)
//            //            view.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.01176470588, blue: 0.01960784314, alpha: 1)
//        } else if pfDurTime == (preFireTime - (preFireTime/2 + preFireTime/4)) {
//            //            shapeLayer.strokeColor = #colorLiteral(red: 0.1550070187, green: 0.2095842698, blue: 0.9921568627, alpha: 1)
//            //            view.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.8392156863, blue: 0.05882352941, alpha: 1)
//        }
        if pfDurTime == 0 {
            //            shapeLayer.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            removeViews()
            timerPreFire.invalidate()
            showPresent()
            timerDuration = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTime), userInfo: nil, repeats: true)
        }
    }
    
    func showPresent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        view.addSubview(presentImageView)
        
        presentImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        presentImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        presentImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        presentImageView.addGestureRecognizer(tapGesture)
        presentImageView.isUserInteractionEnabled = true
        presentImageView.isHidden = false
        view.bringSubviewToFront(presentImageView)
        
    }
    func removeViews() {
        //        shapeLayer.removeFromSuperlayer()
        pfDurationLabel.removeFromSuperview()
        
        
    }
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            presentImageView.removeFromSuperview()
            randomlyPickCharacter()
        }
    }
    
    func randomlyPickCharacter() {
        characterPicked = false
        let numberOfImages: UInt32 = 12
        let random = arc4random_uniform(numberOfImages)
        let imageName = "character_\(random)"
        if characterPicked == false {
            characterImageView.image = UIImage(named: imageName)
            view.addSubview(characterImageView)
            
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            characterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            characterImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
            characterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            characterPicked = true
        }
    }
    
    @objc func fireTime() {
        fireDuration = fireDuration - 1
        if fireDuration == 0 {
            timerDuration.invalidate()
            Sound.shared.stopSound()
            dismiss(animated: true)
        }
    }
    
    func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x,
                               y: view.bounds.size.height * anchorPoint.y)


        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x,
                               y: view.bounds.size.height * view.layer.anchorPoint.y)

        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)

        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
}
