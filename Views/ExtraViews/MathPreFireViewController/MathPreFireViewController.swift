//
//  MathViewController.swift
//  RealmTimers
//
//  Created by Jason Rueckert on 8/13/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import SAConfettiView
import RealmSwift
import UIKit

class MathPreFireViewController: UIViewController {
    
    @IBOutlet weak var firstNumberView: UIView!
    @IBOutlet weak var operatorView: UIView!
    @IBOutlet weak var secondNumberView: UIView!
    @IBOutlet weak var highScoreView: UIView!
    @IBOutlet weak var scoreView: UIView!
    
    //Math vars
    @IBOutlet weak var highScoreLabel: UILabel!
    var highScoreValue = 0 {
        didSet {
            highScoreLabel.text = "\(highScoreValue)"
            UserDefaults.standard.set(highScoreValue, forKey: "highScoreAmount")
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    @IBOutlet weak var firstNumberLabel: UILabel!
    var firstNumber = 0 {
        didSet {
            firstNumberLabel.text = "\(firstNumber)"
        }
    }
    
    @IBOutlet weak var secondNumberLabel: UILabel!
    var secondNumber = 0 {
        didSet {
            secondNumberLabel.text = "\(secondNumber)"
        }
    }
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var answerTextField: UITextField!
    var answer = 0
    // Math vars end
    
    let presentImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "present"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //        @IBOutlet weak var characterImage: UIImageView!
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    @IBOutlet weak var pfDurationLabel: UILabel!
    
    var timerPreFire = Timer()
    var timerDuration = Timer()
    var preFireTime: Int!
    var fireDuration = 0
    var pfDurTime = 0 {
        didSet {
            pfDurationLabel.text = "\(pfDurTime)"
        }
    }
    
    var characterPicked = false
//    @IBOutlet weak var presentView: UIImageView!
    
    fileprivate func setupDurationLabel() {
        pfDurationLabel.translatesAutoresizingMaskIntoConstraints = false
        pfDurationLabel.textAlignment = .center
        pfDurationLabel.lineBreakMode = .byWordWrapping
        pfDurationLabel.numberOfLines = 0
        
        self.view.addSubview(pfDurationLabel)
        pfDurTime = preFireTime
    }
    
    var confettiView = SAConfettiView()
    
    fileprivate func createConfetti() {
        confettiView = SAConfettiView(frame: self.view.bounds)
        confettiView.type = .Confetti
        self.view.addSubview(confettiView)
    }
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor(named: "MathBackground")
        print("Showing Math from within MathPreFireVC")
        DataTimer.shared.check()
        let now = Date()
        let lastDayCheck: Date = UserDefaults.standard.object(forKey: "kStartDate") as! Date
        if now < lastDayCheck {
            print("less than today's date")
        } else {
            print("\(lastDayCheck)")
        }
        setupDurationLabel()
        fireDuration = pfDurTime
        timerPreFire = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownDuration), userInfo: nil, repeats: true)
        startMath()
        viewsSetup()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateViews()
    }
   
    
    fileprivate func animateViews() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.firstNumberView.transform = .identity
            self.firstNumberView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.operatorView.transform = .identity
            self.operatorView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.secondNumberView.transform = .identity
            self.secondNumberView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.highScoreView.transform = .identity
            self.highScoreView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.scoreView.transform = .identity
            self.scoreView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.3, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.answerTextField.transform = .identity
            self.answerTextField.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.4, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.submitButton.transform = .identity
            self.submitButton.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.4, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.pfDurationLabel.transform = .identity
            self.pfDurationLabel.alpha = 1
        }, completion: nil)
    }
    
    func viewsSetup() {
        viewToChange(view: firstNumberView)
        viewToChange(view: operatorView)
        viewToChange(view: secondNumberView)
        viewToChange(view: highScoreView)
        viewToChange(view: scoreView)
        viewToChange(view: answerTextField)
        viewToChange(view: submitButton)
        viewToChange(view: pfDurationLabel)
    }
    func viewToChange(view: UIView) {
        view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        view.alpha = 0
        view.addCornerRadius(radius: 10)
    }
    // MARK:- Math Game
    
    func startMath() {
        self.hideKeyboardWhenTappedAround()
        newEquation()
        showHighScore()
        
        
        showButtons()
    }
    
    func showHighScore() {
        highScoreValue = UserDefaults.standard.integer(forKey: "highScoreAmount")
        highScoreLabel.text = "\(highScoreValue)"
    }
    
    func newEquation() {
        reset()
        firstNumber = Int.random(in: 1..<11)
        secondNumber = Int.random(in: 1..<11)
    }
    
    fileprivate func scoreingButtons() {
        let resetScoreButton:UIButton = UIButton(frame: CGRect(x: view.frame.size.width - 150, y: 480, width: 100, height: 50))
        resetScoreButton.layer.cornerRadius = 10
        resetScoreButton.backgroundColor = .black
        resetScoreButton.setTitle("r Score", for: .normal)
        resetScoreButton.addTarget(self, action:#selector(resetScoreButtonClicked), for: .touchUpInside)
        self.view.addSubview(resetScoreButton)
        
        let resetHighScoreButton:UIButton = UIButton(frame: CGRect(x: 50, y: 480, width: 100, height: 50))
        resetHighScoreButton.layer.cornerRadius = 10
        resetHighScoreButton.backgroundColor = .blue
        resetHighScoreButton.setTitle("r High Score", for: .normal)
        resetHighScoreButton.addTarget(self, action:#selector(resetHighScoreButtonClicked), for: .touchUpInside)
        self.view.addSubview(resetHighScoreButton)
    }
    
    func showButtons() {
        #if DEVELOPMENT
        //Turn on for dev work on the scoring
//        scoreingButtons()
        
        let closeButton:UIButton = UIButton(frame: CGRect(x: view.center.x, y: view.frame.size.height - 100, width: 50, height: 50))
        closeButton.backgroundColor = .red
        closeButton.setTitle("X", for: .normal)
        closeButton.addTarget(self, action:#selector(closeTapped), for: .touchUpInside)
        self.view.addSubview(closeButton)
        view.bringSubviewToFront(closeButton)
        #endif
    }
    
    @IBAction func submitAnswer(_ sender: UIButton) {
        guard let answer = Int(answerTextField.text!) else { return }
        let ans = checkAnswer(num1: firstNumber, num2: secondNumber, answer: answer)
        if ans {
            view.backgroundColor = .green
            score += 1
            answerTextField.resignFirstResponder()
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
        view.backgroundColor = UIColor(named: "MathBackground")
    }
    
    @objc func resetScoreButtonClicked(_ sender: UIButton) {
        score = 0
    }
    
    @objc func resetHighScoreButtonClicked(_ sender: UIButton) {
        highScoreValue = 0
    }
    
    @objc func closeTapped(_ sender: FloatingActionButton) {
//        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
    
    
    fileprivate func highScoreReached() {
        if highScoreValue < score {
            highScoreValue = score
            createConfetti()
            confettiView.startConfetti()
            highScoreView.transform = CGAffineTransform(scaleX: 5, y: 5)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                self.highScoreView.transform = .identity
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.confettiView.stopConfetti()
                print("confetti should stop now")
            }
        }
    }
    
    @objc func countDownDuration() {
        pfDurTime = pfDurTime - 1
        pfDurationLabel.text = "\(pfDurTime)"
//        pfDurationLabel.transform = .identity
//        while pfDurTime < 5 {
//            UIView.animate(withDuration: 0.2) {
//                self.pfDurationLabel.transform = CGAffineTransform(scaleX: 5, y: 5)
//                self.pfDurationLabel.alpha = 0
//            }
//        }
        if pfDurTime == 0 {
            view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            timerPreFire.invalidate()
            removeViews()
            highScoreReached()
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
        pfDurationLabel.removeFromSuperview()
        firstNumberView.removeFromSuperview()
        secondNumberView.removeFromSuperview()
        operatorView.removeFromSuperview()
        answerTextField.removeFromSuperview()
        submitButton.removeFromSuperview()
        
    }
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
                rotateView(targetView: presentImageView, duration: 0.2)
//            UIView.animate(withDuration: 0.5) {
//                self.presentImageView.transform = CGAffineTransform(rotationAngle: .pi)
//            }
            createConfetti()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.confettiView.startConfetti()
                self.presentImageView.removeFromSuperview()
                self.randomlyPickCharacter()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.confettiView.stopConfetti()
            }
        }
    }
    
    func rotateView(targetView: UIView, duration: Double = 1.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(Double.pi))
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
    
    @objc func fireTime() {
        fireDuration = fireDuration - 1
        if fireDuration == 0 {
            timerDuration.invalidate()
            Sound.shared.stopSound()
            characterImageView.removeFromSuperview()
            confettiView.removeFromSuperview()
//            dismiss(animated: true)
            performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
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
}

// MARK:- ---> UITextFieldDelegate

extension MathPreFireViewController: UITextFieldDelegate {
    
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