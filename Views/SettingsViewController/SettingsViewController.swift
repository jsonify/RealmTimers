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
    @IBOutlet weak var soundSwitch: UISwitch!
    
    var soundSelectionButton = DropDownButton()
    
    var defaults = UserDefaults.standard
    
    @IBAction func soundEnabled(_ sender: UISwitch) {
        if soundSwitch.isOn {
            defaults.set(true, forKey: "soundEnabledKey")
        } else {
            defaults.set(false, forKey: "soundEnabledKey")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.transform = CGAffineTransform(translationX: view.frame.width - 260, y: 0)
        soundView.addShadowAndRoundedCorners()
        generalView.addShadowAndRoundedCorners()
        soundSwitch.isOn = defaults.bool(forKey: "soundEnabledKey")
        setupDropDownButton()
    }
    
    fileprivate func setupDropDownButton() {
        soundSelectionButton = DropDownButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        soundSelectionButton.setTitle("Sound Selection", for: .normal)
        soundSelectionButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(soundSelectionButton)
        soundSelectionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        soundSelectionButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        soundSelectionButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        soundSelectionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        soundSelectionButton.dropView.dropDownOptions = ["Heavy Rain", "Ocean Waves", "Clothes Dryer"]
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
