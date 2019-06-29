//
//  PopupUIView.swift
//  RealmTimers
//
//  Created by Jason on 6/28/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class PopupUIView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 15
        layer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: 0, blur: 25, spread: -9)
        backgroundColor = Theme.primaryColor
    }

}
