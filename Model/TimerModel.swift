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
    @objc dynamic var name = ""
    @objc dynamic var preFireDuration = ""
    @objc dynamic var fireDuration = ""
    
    convenience init(name: String, preFireDuration: String, fireDuration: String) {
        self.init()
        self.name = name
        self.preFireDuration = preFireDuration
        self.fireDuration = fireDuration
    }
    
}
