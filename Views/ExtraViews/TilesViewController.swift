//
//  ViewController.swift
//  MagicalGrid
//
//  Created by Jason Rueckert on 8/12/19.
//  Copyright © 2019 Jason Rueckert. All rights reserved.
//

import UIKit

class TilesViewController: UIViewController {
    
    var cells = [String: UIView]()
    var preFireTime: Int!
    let numViewPerRow = 6
    var numViewPerCol = 9
    var cellTotal = 0
    var timer = Timer()

    var clickedCells = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellTotal = numViewPerCol * numViewPerRow
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        for j in 0...numViewPerCol {
            for i in 0...numViewPerRow {
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                // if cell border is desired
//                cellView.layer.borderWidth = 0.5
//                cellView.layer.borderColor = UIColor.black.cgColor
                view.addSubview(cellView)
                
                let key = "\(i)|\(j)"
                cells[key] = cellView
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    var selectedCell: UIView?
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        let width = view.frame.width / CGFloat(numViewPerRow)
//        print(location)
        
        let i = Int(location.x / width)
        let j = Int(location.y / width)
//        print(i, j)
        
        let key = "\(i)|\(j)"
        guard let cellView = cells[key] else { return }
        
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        selectedCell = cellView
        
        
        view.bringSubviewToFront(cellView)
        
        // this is where I can have the cells change based on the time!
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            cellView?.backgroundColor = .black
//        }, completion: nil)
  
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)
        
        if gesture.state == .ended {
            cellView.backgroundColor = .clear
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DIdentity
            }, completion: { (_) in
                
            })
            clickedCells += 1
            
            print(clickedCells)
            if clickedCells == (cellTotal + 2) {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    
    
    func randomColor() -> UIColor {
        let red = CGFloat(Float.random(in: 0.1..<0.9))
        let _ = CGFloat(Float.random(in: 0.1..<0.9))
        let _ = CGFloat(Float.random(in: 0.1..<0.9))
        return UIColor(displayP3Red: red, green: 0, blue: 0, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    @IBAction func closeTapped(_ sender: UIButtonX) {
        dismiss(animated: true, completion: nil)
    }
    
}

