//
//  CustomLabel.swift
//  RealmTimers
//
//  Created by Jason Rueckert on 8/14/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }

    func initializeLabel() {

        self.textAlignment = .left
        self.font = UIFont(name: "Helvetica", size: 17)
        self.textColor = UIColor.black

    }

}
