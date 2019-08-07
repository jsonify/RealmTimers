//
//  ToDoListItem.swift
//  RealmTimers
//
//  Created by Jason on 6/26/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import Foundation
import RealmSwift

class TimerModel: Object {
    @objc dynamic var timerTime = Date()
    @objc dynamic var preFireDuration = ""
    
    convenience init(timerTime: Date, preFireDuration: String) {
        self.init()
        self.timerTime = timerTime
        self.preFireDuration = preFireDuration
    }
    
}
