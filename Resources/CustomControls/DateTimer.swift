//
//  DateTimer.swift
//  RealmTimers
//
//  Created by Jason Rueckert on 8/17/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import Foundation

class DataTimer {
    
    static var shared = DataTimer()
    
    var startDate: Date!
    var endDate: Date!
    
    private init() {
        check()
    }
    
    func check() {
        guard
            let startDate = UserDefaults.standard.object(forKey: "kStartDate") as? Date,
            let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)
            else {
                self.resetDates()
                return
        }
        
        var interval = Date().timeIntervalSince(endDate)
        guard interval < 0 else {
            self.resetUserData()
            self.resetDates()
            return
        }
        
        self.startDate = startDate
        self.endDate = endDate
        
        // log remaining time
        interval = abs(interval)
        let log: [Int] = [3600.0, 60.0].map { value in
            guard interval > value else { return 0 }
            
            let returnValue = Int(floor(interval / value))
            interval.formTruncatingRemainder(dividingBy: value)
            return returnValue
        }
        print("Remaining: \(log[0])h \(log[1])m \(Int(interval))s")
    }
    
    private func resetUserData() {
        UserDefaults.standard.set(0, forKey: "highScoreAmount")
    }
    
    private func resetDates() {
        self.startDate = Date()
        self.endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        UserDefaults.standard.set(startDate, forKey: "kStartDate")
    }
}
