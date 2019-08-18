//
//  PreFireViewController.swift
//  RealmTimers
//
//  Created by Jason on 7/8/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import SAConfettiView
import RealmSwift
import UIKit

class PreFireViewController: UIViewController {
    
    //Math vars
    var highScoreLabel = CustomLabel()
    var highScoreValue = 0 {
        didSet {
            highScoreLabel.text = "High Score: \(highScoreValue)"
            UserDefaults.standard.set(highScoreValue, forKey: "highScoreAmount")
        }
    }
    
    var scoreLabel = CustomLabel()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var firstNumberLabel = CustomLabel()
    var firstNumber = 0 {
        didSet {
            firstNumberLabel.text = "\(firstNumber)"
        }
    }
    
    var operatorLabel = CustomLabel()
    
    var secondNumberLabel = CustomLabel()
    var secondNumber = 0 {
        didSet {
            secondNumberLabel.text = "\(secondNumber)"
        }
    }
    
    var answerTextField = UITextField()
    var answer = 0
    // Math vars end
    //
    //    var defaults = UserDefaults.standard
    //    var highScoreAmount = "highScoreAmount"
    
    var submitButton = UIButton()
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var pfDuration: UILabel!
    
    var timerPreFire = Timer()
    var timerDuration = Timer()
    var preFireTime: Int!
    var fireDuration = 0
    let preFireDurationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    var pfLabel: UILabel!
    var pfDurTime = 0 {
        didSet {
            pfDuration.text = "\(pfDurTime)"
        }
    }
    
    var characterPicked = false
    
    var shapeLayer = CAShapeLayer()
    @IBOutlet weak var presentView: UIImageView!
    
    fileprivate func setupDurationLabel() {
        pfDuration.translatesAutoresizingMaskIntoConstraints = false
        pfDuration.textAlignment = .center
        pfDuration.lineBreakMode = .byWordWrapping
        pfDuration.numberOfLines = 0
        self.view.addSubview(pfDuration)
        
        //        pfDuration.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        //        pfDuration.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        pfDuration.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pfDurTime = preFireTime
    }
    
    var confettiView = SAConfettiView()
    
    fileprivate func createConfetti() {
        confettiView = SAConfettiView(frame: self.view.bounds)
        confettiView.type = .Confetti
        self.view.addSubview(confettiView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDurationLabel()
        fireDuration = pfDurTime
        timerPreFire = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownDuration), userInfo: nil, repeats: true)
        startMath()
        
        //        drawPreFireCircle1(color: UIColor.green)
        
    }
    
    // MARK:- Math Game
    
    func startMath() {
        self.hideKeyboardWhenTappedAround()
        newEquation()
        showHighScore()
        showScore()
        showAnswerTextField()
        showButtons()
    }
    
    fileprivate func showAnswerTextField() {
        answerTextField =  UITextField(frame: CGRect(x: (view.frame.size.width/2) - 75, y: view.frame.size.height/2 - 35, width: 150, height: 70))
        answerTextField.placeholder = "Enter text here"
        answerTextField.font = UIFont.systemFont(ofSize: 40)
        answerTextField.borderStyle = UITextField.BorderStyle.roundedRect
        answerTextField.autocorrectionType = UITextAutocorrectionType.no
        answerTextField.keyboardType = UIKeyboardType.numberPad
        answerTextField.returnKeyType = UIReturnKeyType.done
        answerTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        answerTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        answerTextField.delegate = self
        self.view.addSubview(answerTextField)
    }
    
    func showHighScore() {
        highScoreValue = UserDefaults.standard.integer(forKey: "highScoreAmount")
        highScoreLabel = CustomLabel(frame: CGRect(x: view.frame.size.width/2, y: 50, width: 200, height: 20))
        view.addSubview(highScoreLabel)
        highScoreLabel.text = "High Score: \(highScoreValue)"
    }
    
    func showScore() {
        scoreLabel = CustomLabel(frame: CGRect(x: view.frame.size.width/2, y: 75, width: 200, height: 20))
        view.addSubview(scoreLabel)
        scoreLabel.text = "Score: \(score)"
    }
    
    func newEquation() {
        reset()
        
        firstNumberLabel.text = ""
        firstNumberLabel = CustomLabel(frame: CGRect(x: view.frame.size.width/4, y: 185, width: 100, height: 120))
        view.addSubview(firstNumberLabel)
        firstNumberLabel.text = "\(firstNumber)"
        firstNumberLabel.font = UIFont(name: "LibreBaskerville-Regular", size: 75)
        
        secondNumberLabel.text = ""
        secondNumberLabel = CustomLabel(frame: CGRect(x: ((view.frame.size.width/2) + (view.frame.size.width/4) - 20), y: 185, width: 100, height: 120))
        view.addSubview(secondNumberLabel)
        secondNumberLabel.text = "\(secondNumber)"
        secondNumberLabel.font = UIFont(name: "LibreBaskerville-Regular", size: 75)
        
        operatorLabel = CustomLabel(frame: CGRect(x: view.frame.size.width/2, y: 185, width: 200, height: 120))
        operatorLabel.text = "+"
        view.addSubview(operatorLabel)
        operatorLabel.font = UIFont(name: "Helvetica", size: 50)
        
        firstNumber = Int.random(in: 1..<11)
        secondNumber = Int.random(in: 1..<11)
    }
    
    func showButtons() {
        submitButton = UIButton(frame: CGRect(x: view.frame.size.width/2 - 50, y: 400, width: 100, height: 50))
        submitButton.backgroundColor = .black
        submitButton.setTitle("Try it!", for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        let resetScoreButton:UIButton = UIButton(frame: CGRect(x: (view.frame.size.width/2) - 50, y: 480, width: 100, height: 50))
        resetScoreButton.layer.cornerRadius = 10
        resetScoreButton.backgroundColor = .black
        resetScoreButton.setTitle("Reset Score", for: .normal)
        resetScoreButton.addTarget(self, action:#selector(resetScoreButtonClicked), for: .touchUpInside)
        
        let closeButton:UIButton = UIButton(frame: CGRect(x: view.frame.size.width/2, y: view.frame.size.height - 100, width: 50, height: 50))
        closeButton.backgroundColor = .red
        closeButton.setTitle("X", for: .normal)
        closeButton.addTarget(self, action:#selector(closeTapped), for: .touchUpInside)
        //        Used for testing
        //        self.view.addSubview(resetScoreButton)
        //        self.view.addSubview(closeButton)
    }
    
    @objc func buttonClicked() {
        guard let answer = Int(answerTextField.text!) else { return }
        let ans = checkAnswer(num1: firstNumber, num2: secondNumber, answer: answer)
        if ans {
            view.backgroundColor = .green
            score += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.newEquation()
            }
        } else {
            view.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.reset()
            }
        }
        
    }
    
    func checkAnswer(num1: Int, num2: Int, answer: Int) -> Bool {
        if answer == (num1 + num2) {
            return true
        }
        return false
    }
    
    func reset() {
        answerTextField.text = ""
        view.backgroundColor = .lightGray
        
    }
    
    @objc func resetScoreButtonClicked(_ sender: UIButton) {
        score = 0
    }
    
    @objc func closeTapped(_ sender: FloatingActionButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Circle Option
    
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
        pfDuration.text = "\(pfDurTime)"
        if pfDurTime == (preFireTime - (preFireTime/4)) {
            //            shapeLayer.strokeColor = #colorLiteral(red: 0.7568627596, green: 0.6892270425, blue: 0.2031356938, alpha: 1)
            //            view.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.3803921569, blue: 0.8901960784, alpha: 1)
        } else if pfDurTime == (preFireTime - (preFireTime/2)) {
            //            shapeLayer.strokeColor = #colorLiteral(red: 0.07886815806, green: 0.8549019694, blue: 0.7889860416, alpha: 1)
            //            view.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.01176470588, blue: 0.01960784314, alpha: 1)
        } else if pfDurTime == (preFireTime - (preFireTime/2 + preFireTime/4)) {
            //            shapeLayer.strokeColor = #colorLiteral(red: 0.1550070187, green: 0.2095842698, blue: 0.9921568627, alpha: 1)
            //            view.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.8392156863, blue: 0.05882352941, alpha: 1)
        }
        if pfDurTime == 0 {
//            shapeLayer.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            removeViews()
            timerPreFire.invalidate()
            if highScoreValue < score {
                highScoreValue = score
                createConfetti()
                confettiView.startConfetti()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.confettiView.stopConfetti()
                    print("confetti should stop now")
                }
            }
            showPresent()
            timerDuration = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTime), userInfo: nil, repeats: true)
        }
    }
    
    func showPresent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        presentView.addGestureRecognizer(tapGesture)
        presentView.isUserInteractionEnabled = true
        presentView.isHidden = false
        view.bringSubviewToFront(presentView)
        
    }
    func removeViews() {
        shapeLayer.removeFromSuperlayer()
        pfDuration.removeFromSuperview()
        firstNumberLabel.removeFromSuperview()
        secondNumberLabel.removeFromSuperview()
        operatorLabel.removeFromSuperview()
        answerTextField.removeFromSuperview()
        submitButton.removeFromSuperview()
        
    }
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            presentView.removeFromSuperview()
            randomlyPickCharacter()
        }
    }
    
    @objc func fireTime() {
        fireDuration = fireDuration - 1
        if fireDuration == 0 {
            timerDuration.invalidate()
            Sound.shared.stopSound()
            //            saveHighScore()
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
    
    func randomlyPickCharacter() {
        characterPicked = false
        let numberOfImages: UInt32 = 12
        let random = arc4random_uniform(numberOfImages)
        let imageName = "character_\(random)"
        if characterPicked == false {
            characterImage.image = UIImage(named: imageName)
            characterPicked = true
        }
    }
}


// MARK:- ---> UITextFieldDelegate

extension PreFireViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
//        print("TextField should begin editing method called")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
//        print("TextField did begin editing method called")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//        print("TextField should snd editing method called")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//        print("TextField did end editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
//        print("TextField did end editing with reason method called")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
//        print("While entering the characters this method gets called")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
//        print("TextField should clear method called")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
//        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }
    
}

// MARK: UITextFieldDelegate <---
