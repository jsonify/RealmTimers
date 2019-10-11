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
    @IBOutlet weak var gradientView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.addGradientBackground(firstColor: UIColor(red:0.00, green:0.57, blue:0.85, alpha:1.0), secondColor: UIColor(red:0.40, green:0.00, blue:0.80, alpha:1.0))
//        cardView.addGradientBackground(firstColor: .white, secondColor: .black)
    }
    
    
}

