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
    @objc dynamic var id: String!
    @objc dynamic var timerName = ""
    @objc dynamic var timerTime = Date()
    @objc dynamic var preFireDuration = ""
    
    convenience init(timerName: String,timerTime: Date, preFireDuration: String) {
        self.init()
        id = UUID().uuidString
        self.timerName = timerName
        self.timerTime = timerTime
        self.preFireDuration = preFireDuration
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
