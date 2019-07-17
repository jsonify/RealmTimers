//
//  PreFireViewController.swift
//  RealmTimers
//
//  Created by Jason on 7/8/19.
//  Copyright © 2019 Jason. All rights reserved.
//
import MBCircularProgressBar
import RealmSwift
import UIKit

class PreFireViewController: UIViewController {

//    var timer = TimerModel()
    var preFireTime: Int?
    var realm: Realm!
    var timerItem: Results<TimerModel>{
        get {
            return realm.objects(TimerModel.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get the preFire time
        realm = try! Realm()
        print("\(timerItem[0].preFireDuration)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 10.0) {
            
        }
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

