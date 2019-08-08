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
        
        backgroundColor = #colorLiteral(red: 0.1545447111, green: 0.3621617556, blue: 0.9042051435, alpha: 1)
        layer.cornerRadius = frame.height / 2
        setTitleColor(Theme.primaryColor, for: .normal)
    }

}
