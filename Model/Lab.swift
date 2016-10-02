//
//  Lab.swift
//  HealthHacks
//
//  Created by Nasheya Rahman on 10/2/16.
//  Copyright © 2016 Nasheya Rahman. All rights reserved.
//

import Foundation

class Lab: Notification{
    let type: String
    let result: String
    
    init(person: Patient, urgency: UrgencyLevels, testType: String, testResult: String){
        type = testType
        result = testResult
        super.init(person: person, notify: true, urgentLevel: urgency, notifyTime: NSDate() as Date)
    }
    
    override var description: String {
        return "The \(type) test for \(person.description) in room \(person.roomNum) came back"
    }
    
    override var descriptionShort: String {
        return description
    }
    
    override var descriptionLong: String {
        var str = description
        str += " with the results of \(result)"
        return str
    }
}
