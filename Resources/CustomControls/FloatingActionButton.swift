//
//  FloatingActionButton.swift
//  RealmTimers
//
//  Created by Jason Rueckert on 8/9/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class FloatingActionButton: UIButtonX {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        UIView.animate(withDuration: 0.3) {
            if self.transform == .identity {
                self.transform = CGAffineTransform(rotationAngle: 45 * (.pi/180))
//                self.backgroundColor = Theme.darkTintColor
                self.backgroundColor = Theme.fabDarkRed
            } else {
                self.transform = .identity
//                self.backgroundColor = Theme.tintColor
                self.backgroundColor = Theme.fabRed
            }
        }
        
        return super.beginTracking(touch, with: event)
    }
}
