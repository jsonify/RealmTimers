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
    @objc dynamic var preFireStyle = ""
    
    convenience init(timerName: String, timerTime: Date, preFireDuration: String, preFireStyle: String) {
        self.init()
        id = UUID().uuidString
        self.timerName = timerName
        self.timerTime = timerTime
        self.preFireDuration = preFireDuration
        self.preFireStyle = preFireStyle
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
