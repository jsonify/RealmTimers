//
//  MathViewController.swift
//  RealmTimers
//
//  Created by Jason Rueckert on 8/13/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class MathViewController: UIViewController {

    var highScoreLabel = CustomLabel()
    var highScoreValue = 0 {
        didSet {
            highScoreLabel.text = "High Score: \(highScoreValue)"
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        newEquation()
        showHighScore()
        showScore()
        showAnswerTextField()
        showButtons()
    }
    
    fileprivate func showAnswerTextField() {
        answerTextField =  UITextField(frame: CGRect(x: 20, y: view.frame.size.height/2, width: 300, height: 40))
        answerTextField.placeholder = "Enter text here"
        answerTextField.font = UIFont.systemFont(ofSize: 15)
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
        highScoreLabel = CustomLabel(frame: CGRect(x: view.frame.size.width/2, y: 50, width: 200, height: 20))
        view.addSubview(highScoreLabel)
        highScoreLabel.text = "High Score: \(score)"
    }
    
    func showScore() {
        scoreLabel = CustomLabel(frame: CGRect(x: view.frame.size.width/2, y: 75, width: 200, height: 20))
        view.addSubview(scoreLabel)
        scoreLabel.text = "Score: \(score)"
    }
    
    func newEquation() {
        reset()
        
        firstNumberLabel.text = ""
        firstNumberLabel = CustomLabel(frame: CGRect(x: view.frame.size.width/4, y: 185, width: 200, height: 120))
        view.addSubview(firstNumberLabel)
        firstNumberLabel.text = "\(firstNumber)"
        firstNumberLabel.font = UIFont(name: "Helvetica", size: 50)
        
        secondNumberLabel.text = ""
        secondNumberLabel = CustomLabel(frame: CGRect(x: ((view.frame.size.width/2) + (view.frame.size.width/4) - 50), y: 185, width: 200, height: 120))
        view.addSubview(secondNumberLabel)
        secondNumberLabel.text = "\(secondNumber)"
        secondNumberLabel.font = UIFont(name: "Helvetica", size: 50)
        
        operatorLabel = CustomLabel(frame: CGRect(x: view.frame.size.width/2, y: 185, width: 200, height: 120))
        view.addSubview(operatorLabel)
        operatorLabel.text = "+"
        operatorLabel.font = UIFont(name: "Helvetica", size: 50)
        
        firstNumber = Int.random(in: 1..<11)
        secondNumber = Int.random(in: 1..<11)
    }
    
    func showButtons() {
        let submitButton:UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
        submitButton.backgroundColor = .black
        submitButton.setTitle("Try it!", for: .normal)
        submitButton.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        self.view.addSubview(submitButton)

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
        if highScoreValue < score {
        highScoreValue = score
        }
    }
    
    func checkAnswer(num1: Int, num2: Int, answer: Int) -> Bool {
        if answer == (num1 + num2) {
            return true
        }
        return false
    }
    
//    @IBAction func submitTapped(_ sender: UIButton) {
//        guard let answer = Int(answerTextField.text!) else { return }
//        let ans = checkAnswer(num1: firstNumber, num2: secondNumber, answer: answer)
//        if ans {
//            view.backgroundColor = .green
//            score += 1
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.newEquation()
//            }
//        } else {
//            view.backgroundColor = .red
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.reset()
//            }
//        }
//        if highScoreValue < score {
//        highScoreValue = score
//        }
//    }
    
    func reset() {
        answerTextField.text = ""
        view.backgroundColor = .lightGray
        
    }
    
    @IBAction func resetScore(_ sender: UIButton) {
//        scoreLabel.removeFromSuperview()
        score = 0
        
    }
    @IBAction func closeTapped(_ sender: FloatingActionButton) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK:- ---> UITextFieldDelegate

extension MathViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }

}

// MARK: UITextFieldDelegate <---
