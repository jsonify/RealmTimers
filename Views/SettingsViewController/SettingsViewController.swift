//
//  SettingsViewController.swift
//  RealmTimers
//
//  Created by Jason Rueckert on 7/24/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var soundView: UIViewX!
    @IBOutlet weak var generalView: UIViewX!
    @IBOutlet weak var closeButton: FloatingActionButton!
    @IBOutlet weak var debugSwitch: UISwitch!
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugSwitch.isOn = defaults.bool(forKey: "debugValue")
        closeButton.transform = CGAffineTransform(translationX: view.frame.width - 260, y: 0)
        soundView.addShadowAndRoundedCorners()
        generalView.addShadowAndRoundedCorners()
        print("\(String(describing: debugSwitch.value(forKey: "debugValue")))")
        
    }
    
    @IBAction func debugAction(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "debugValue")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveButton()
    }
    
    func moveButton() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.closeButton.transform = .identity
            
        }) { (true) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                self.closeButton.transform = CGAffineTransform(rotationAngle: 45 * -(.pi/180))
            })
            
        }
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
