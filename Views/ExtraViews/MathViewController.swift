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
    
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    @IBOutlet weak var firstNumberLabel: UILabel!
    var firstNumber = 0 {
        didSet {
            firstNumberLabel.text = "\(firstNumber)"
        }
    }
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    var secondNumber = 0 {
        didSet {
            secondNumberLabel.text = "\(secondNumber)"
        }
    }
    @IBOutlet weak var answerTextField: UITextField!
    var answer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        newEquation()
        showHighScore()
    }
    
    func showHighScore() {
        highScoreLabel = CustomLabel(frame: CGRect(x: view.frame.size.width/2, y: 50, width: 200, height: 20))
        view.addSubview(highScoreLabel)
        highScoreLabel.text = "High Score: \(score)"
    }
    
    func checkAnswer(num1: Int, num2: Int, answer: Int) -> Bool {
        if answer == (num1 + num2) {
            return true
        }
        return false
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
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
    
    func newEquation() {
        reset()
        firstNumber = Int.random(in: 1..<11)
        secondNumber = Int.random(in: 1..<11)
    }
    
    func reset() {
        answerTextField.text = ""
        view.backgroundColor = .lightGray
    }
    
    @IBAction func resetScore(_ sender: UIButton) {
        score = 0
    }
    @IBAction func closeTapped(_ sender: FloatingActionButton) {
        dismiss(animated: true, completion: nil)
    }
}
