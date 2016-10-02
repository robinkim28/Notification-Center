//
//  Notification.swift
//  HealthHacks
//
//  Created by Nasheya Rahman on 10/1/16.
//  Copyright © 2016 Nasheya Rahman. All rights reserved.
//

import Foundation

class Notification: CustomStringConvertible {
    enum UrgencyLevels: Int{
        case red = 0, yellow, green
    }
    
    let urgency: UrgencyLevels
    let subscribe: Bool
    let done: Bool
    
    let dateAndTimeCreated:NSDate = NSDate()
    let timeToNotify: Date
    
    let person: Patient
    
    init(person: Patient, notify: Bool, urgentLevel: UrgencyLevels, notifyTime: Date){
        self.person = person
        subscribe = notify
        urgency = urgentLevel
        done = false
        timeToNotify = notifyTime
    }
    
    var description: String {
        return "\(person.description) needs care in room \(person.roomNum)"
    }
    
    var descriptionLong: String {
        return description
    }
    
    var descriptionShort: String {
        return description
    }
}
