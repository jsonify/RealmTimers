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
    
    var bars1 = [MyCustomView]()
    var bars2 = [MyCustomView]()
    var bars3 = [MyCustomView]()
    var bars4 = [MyCustomView]()
    
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
        print("Showing Bars from within BarsPreFireVC")
        #if DEVELOPMENT
        showButtons()
        #endif
        drawPreFireBars4(color: .brown)
        drawPreFireBars3(color: .orange)
        drawPreFireBars2(color: UIColor.blue)
        drawPreFireBars1(color: .purple)
        showLabel()
        fireDuration = pfDurTime
        timerPreFire = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownDuration), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drain1()
    }
    
    func drawPreFireBars1(color: UIColor) {
        let barWidth = view.frame.size.width/3
        let barHeight = view.frame.size.height
        
        let bar1 = MyCustomView(frame: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
        bar1.backgroundColor = color
        bars1.append(bar1)
        
        let bar2 = MyCustomView(frame: CGRect(x: barWidth, y: 0, width: barWidth, height: barHeight))
        bar2.backgroundColor = color
        bars1.append(bar2)
        
        let bar3 = MyCustomView(frame: CGRect(x: barWidth * 2, y: 0, width: barWidth, height: barHeight))
        bar3.backgroundColor = color
        bars1.append(bar3)
        
        for bar in bars1 {
            setAnchorPoint(anchorPoint: CGPoint(x: 0, y: 0), forView: bar)
            self.view.addSubview(bar)
        }
    }
    
    func drawPreFireBars2(color: UIColor) {
        let barWidth = view.frame.size.width/3
        let barHeight = view.frame.size.height
        
        let bar1 = MyCustomView(frame: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
        bar1.backgroundColor = color
        
        bars2.append(bar1)
        
        let bar2 = MyCustomView(frame: CGRect(x: barWidth, y: 0, width: barWidth, height: barHeight))
        bar2.backgroundColor = color
        bars2.append(bar2)
        
        let bar3 = MyCustomView(frame: CGRect(x: barWidth * 2, y: 0, width: barWidth, height: barHeight))
        bar3.backgroundColor = color
        bars2.append(bar3)
        
        for bar in bars2 {
            setAnchorPoint(anchorPoint: CGPoint(x: 0, y: 0), forView: bar)
            self.view.addSubview(bar)
        }
    }
    
    func drawPreFireBars3(color: UIColor) {
        let barWidth = view.frame.size.width/3
        let barHeight = view.frame.size.height
        
        let bar1 = MyCustomView(frame: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
        bar1.backgroundColor = color
        bars3.append(bar1)
        
        let bar2 = MyCustomView(frame: CGRect(x: barWidth, y: 0, width: barWidth, height: barHeight))
        bar2.backgroundColor = color
        bars3.append(bar2)
        
        let bar3 = MyCustomView(frame: CGRect(x: barWidth * 2, y: 0, width: barWidth, height: barHeight))
        bar3.backgroundColor = color
        bars3.append(bar3)
        
        for bar in bars3 {
            setAnchorPoint(anchorPoint: CGPoint(x: 0, y: 0), forView: bar)
            self.view.addSubview(bar)
        }
    }
    
    func drawPreFireBars4(color: UIColor) {
        let barWidth = view.frame.size.width/3
        let barHeight = view.frame.size.height
        
        let bar1 = MyCustomView(frame: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
        bar1.backgroundColor = color
        bars4.append(bar1)
        
        let bar2 = MyCustomView(frame: CGRect(x: barWidth, y: 0, width: barWidth, height: barHeight))
        bar2.backgroundColor = color
        bars4.append(bar2)
        
        let bar3 = MyCustomView(frame: CGRect(x: barWidth * 2, y: 0, width: barWidth, height: barHeight))
        bar3.backgroundColor = color
        bars4.append(bar3)
        
        for bar in bars4 {
            setAnchorPoint(anchorPoint: CGPoint(x: 0, y: 0), forView: bar)
            self.view.addSubview(bar)
        }
    }
    
    func showLabel() {
        pfDurationLabel = UILabel(frame: CGRect(x: 0, y: 50, width: 400, height: 50))
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
    
    func drain1() {
        UIView.animate(withDuration: TimeInterval(preFireTime/12), delay: 0, options: .curveLinear, animations: {
            self.bars1[0].transform = CGAffineTransform(translationX: 0, y: self.bars1[0].frame.size.height)
        }) { (true) in
            UIView.animate(withDuration: TimeInterval(self.preFireTime/12), delay: 0, options: .curveLinear, animations: {
                self.bars1[1].transform = CGAffineTransform(translationX: 0, y: self.bars1[1].frame.size.height)
            }) { (true) in
                UIView.animate(withDuration: TimeInterval(self.preFireTime/12), delay: 0, options: .curveLinear, animations: {
                    self.bars1[2].transform = CGAffineTransform(translationX: 0, y: self.bars1[2].frame.size.height)
                }) { (true) in
                    self.bars1.removeAll()
                    self.drain2()
                }
            }
        }
    }
    
    func drain2() {
        UIView.animate(withDuration: TimeInterval(preFireTime/12), delay: 0, options: .curveLinear, animations: {
            self.bars2[0].transform = CGAffineTransform(translationX: 0, y: self.bars2[0].frame.size.height)
        }) { (true) in
            UIView.animate(withDuration: TimeInterval(self.preFireTime/12), delay: 0, options: .curveLinear, animations: {
                self.bars2[1].transform = CGAffineTransform(translationX: 0, y: self.bars2[1].frame.size.height)
            }) { (true) in
                UIView.animate(withDuration: TimeInterval(self.preFireTime/12), delay: 0, options: .curveLinear, animations: {
                    self.bars2[2].transform = CGAffineTransform(translationX: 0, y: self.bars2[2].frame.size.height)
                }) { (true) in
                    self.bars2.removeAll()
                    self.drain3()
                }
            }
        }
    }
    
    func drain3() {
        UIView.animate(withDuration: TimeInterval(preFireTime/12), delay: 0, options: .curveLinear, animations: {
            self.bars3[0].transform = CGAffineTransform(translationX: 0, y: self.bars3[0].frame.size.height)
        }) { (true) in
            UIView.animate(withDuration: TimeInterval(self.preFireTime/12), delay: 0, options: .curveLinear, animations: {
                self.bars3[1].transform = CGAffineTransform(translationX: 0, y: self.bars3[1].frame.size.height)
            }) { (true) in
                UIView.animate(withDuration: TimeInterval(self.preFireTime/12), delay: 0, options: .curveLinear, animations: {
                    self.bars3[2].transform = CGAffineTransform(translationX: 0, y: self.bars3[2].frame.size.height)
                }) { (true) in
                    self.bars3.removeAll()
                    self.drain4()
                }
            }
        }
    }
    
    func drain4() {
        UIView.animate(withDuration: TimeInterval(preFireTime/12), delay: 0, options: .curveLinear, animations: {
            self.bars4[0].transform = CGAffineTransform(translationX: 0, y: self.bars4[0].frame.size.height)
        }) { (true) in
            UIView.animate(withDuration: TimeInterval(self.preFireTime/12), delay: 0, options: .curveLinear, animations: {
                self.bars4[1].transform = CGAffineTransform(translationX: 0, y: self.bars4[1].frame.size.height)
            }) { (true) in
                UIView.animate(withDuration: TimeInterval(self.preFireTime/12), delay: 0, options: .curveLinear, animations: {
                    self.bars4[2].transform = CGAffineTransform(translationX: 0, y: self.bars4[2].frame.size.height)
                }) { (true) in
                    self.bars4.removeAll()
                    self.view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                    self.removeViews()
                    self.timerPreFire.invalidate()
                    self.showPresent()
                    self.timerDuration = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.fireTime), userInfo: nil, repeats: true)
                }
            }
        }
    }
    
    @objc func countDownDuration() {
        pfDurTime = pfDurTime - 1
        pfDurationLabel.text = "\(pfDurTime)"
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
