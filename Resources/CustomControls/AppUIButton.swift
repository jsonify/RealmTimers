//
//  AppUIButton.swift
//  RealmTimers
//
//  Created by Jason on 6/28/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class AppUIButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = Theme.pinkTintColor
        layer.cornerRadius = frame.height / 2
        setTitleColor(Theme.primaryColor, for: .normal)
    }

}
