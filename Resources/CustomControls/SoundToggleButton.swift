//
//  SoundToggleButton.swift
//  RealmTimers
//
//  Created by Jason Rueckert on 8/15/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class SoundToggleButton: UIButton {
    var isOn = UserDefaults.standard.bool(forKey: "soundEnabledKey")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    fileprivate func initButton() {
        addTarget(self, action: #selector(SoundToggleButton.buttonPressed), for: .touchUpInside)
        
    }
    
    @objc fileprivate func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    fileprivate func activateButton(bool: Bool) {
        isOn = bool
        let image = bool ? UIImage(named: "sound-on") : UIImage(named: "sound-off")
        if isOn {
            Sound.shared.startSound()
            UserDefaults.standard.set(isOn, forKey: "soundEnabledKey")
        } else {
            Sound.shared.stopSound()
            UserDefaults.standard.set(isOn, forKey: "soundEnabledKey")
        }
        setImage(image, for: .normal)
    }
}
