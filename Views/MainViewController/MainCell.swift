//
//  MainCell.swift
//  RealmTimers
//
//  Created by Jason on 6/27/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var preFireLabel: UILabel!
    @IBOutlet weak var fireDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.addShadowAndRoundedCorners()
        nameLabel.font = UIFont(name: Theme.timerFontName, size: 50)
        preFireLabel.font = UIFont(name: Theme.titleFontName, size: 2)
    }

}
