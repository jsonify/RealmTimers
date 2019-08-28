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
    var shapeLayer1 = CAShapeLayer()
    var shapeLayer2 = CAShapeLayer()
    var shapeLayer3 = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showButtons()
        showLabel()
        
        drawPreFireBars1(color: .red)
        }

    func drawPreFireBars1(color: UIColor) {
        let barWidth = view.frame.size.width/3
        shapeLayer1.fillColor = color.cgColor
        shapeLayer1.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: barWidth, height: view.frame.size.height)).cgPath
        shapeLayer2.fillColor = color.cgColor
        shapeLayer2.path = UIBezierPath(rect: CGRect(x: barWidth, y: 0, width: barWidth, height: view.frame.size.height)).cgPath
        shapeLayer3.fillColor = color.cgColor
        shapeLayer3.path = UIBezierPath(rect: CGRect(x: barWidth * 2, y: 0, width: barWidth, height: view.frame.size.height)).cgPath
        view.layer.addSublayer(shapeLayer1)
        view.layer.addSublayer(shapeLayer2)
        view.layer.addSublayer(shapeLayer3)
    }
    
    func showLabel() {
        let viewLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 50, width: 400, height: 50))
        viewLabel.text = title
        viewLabel.textAlignment = .center
        viewLabel.font = UIFont(name: "Avenir", size: 25)
        self.view.addSubview(viewLabel)
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

}
