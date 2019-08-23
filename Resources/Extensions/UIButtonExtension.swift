//
//  UIButtonExtension.swift
//  RealmTimers
//
//  Created by Jason on 6/28/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

extension UIButton {
    
    func createFloatingActionButton() {
        backgroundColor = Theme.darkTintColor
        layer.cornerRadius = frame.height/2
        layer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: 0, blur: 25, spread: -9)
    }
    
    func createFloatingCancelButton() {
        backgroundColor = Theme.delete
        setImage(UIImage(named: "cancel"), for: .normal)
        layer.cornerRadius = frame.height/2
        layer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: 0, blur: 25, spread: -9)
    }
    
    func createFloatingSaveButton() {
        backgroundColor = Theme.edit
        layer.cornerRadius = frame.height/2
        setImage(UIImage(named: "check"), for: .normal)
        layer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: 0, blur: 25, spread: -9)
    }
    
}
