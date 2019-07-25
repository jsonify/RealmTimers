//
//  ToDoListItem.swift
//  RealmTimers
//
//  Created by Jason on 6/26/19.
//  Copyright © 2019 Jason. All rights reserved.
//
//import SwiftDate
import Foundation
import RealmSwift

class TimerModel: Object {
    @objc dynamic var name = Date()
    @objc dynamic var preFireDuration = ""
    
    convenience init(name: Date, preFireDuration: String) {
        self.init()
        self.name = name
        self.preFireDuration = preFireDuration
    }
    
}
