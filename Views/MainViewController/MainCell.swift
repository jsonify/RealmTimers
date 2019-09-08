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
    @IBOutlet weak var timerNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var preFireLabel: UILabel!
    @IBOutlet weak var preFireStyle: UILabel!
    @IBOutlet weak var avatarImage: UIImageViewX!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.addShadowAndRoundedCorners()
        
    }
}
