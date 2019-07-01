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
    @objc dynamic var preFireDuration = 0
    @objc dynamic var fireDuration = 0
}
