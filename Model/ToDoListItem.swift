//
//  ToDoListItem.swift
//  RealmTimers
//
//  Created by Jason on 6/26/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoListItem: Object {
    @objc dynamic var name = ""
    @objc dynamic var done = false
}
