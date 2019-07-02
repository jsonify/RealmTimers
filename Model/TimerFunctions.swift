//
//  TimerFunctions.swift
//  RealmTimers
//
//  Created by Jason on 7/1/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import Foundation
import RealmSwift

class TimerFunctions {
    var realm = try! Realm()
    
    func createTimer(timerModel: TimerModel) {
        
        do {
            try! realm.write {
                realm.add(timerModel)
            }
        } catch {
            print("Error saving name: \(error)")
        }
    }
}
