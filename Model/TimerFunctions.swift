//
//  TimerFunctions.swift
//  RealmTimers
//
//  Created by Jason on 7/1/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import RealmSwift
import UIKit


class TimerFunctions {
    
    var realm = try! Realm()
    
    func createTimer(timerModel: TimerModel) {
        try! realm.write {
            realm.add(timerModel)
        }
    }
}
