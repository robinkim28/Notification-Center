//
//  Notification.swift
//  HealthHacks
//
//  Created by Nasheya Rahman on 10/1/16.
//  Copyright © 2016 Nasheya Rahman. All rights reserved.
//

import Foundation

class Notification: CustomStringConvertible{
    enum UrgencyLevels: Int{
        case red = 0, yellow, green
    }
    
    static var indexTotal = 0
    let indexDat: Int
    let urgency: UrgencyLevels
    let subscribe: Bool
    let done: Bool
    
    let dateAndTimeCreated:NSDate = NSDate()
    let timeToNotify: Date
    
    //let person: Patient
    
    //init(person: Patient, notifiy: Bool, urgentLevelSpecified: UrgencyLevels){
    init(notify: Bool, urgentLevel: UrgencyLevels, notifyTime: Date){
        //self.person = person
        subscribe = notify
        urgency = urgentLevel
        done = false
        timeToNotify = notifyTime
        Notification.indexTotal = Notification.indexTotal + 1
        indexDat = Notification.indexTotal
        
    }
    
    var description: String {
        return "Nasheya Rahman \(indexDat) \(urgency)"
    }
}
