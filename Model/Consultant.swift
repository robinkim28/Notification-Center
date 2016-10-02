//
//  Consultant.swift
//  HealthHacks
//
//  Created by Nasheya Rahman on 10/2/16.
//  Copyright © 2016 Nasheya Rahman. All rights reserved.
//

import Foundation

class Consultant: Notification{
    let personConsulting: String
    let specialty: String
    let note: String
    
    init(person: Patient, urgency: UrgencyLevels, consultant: String, department: String, note: String){
        personConsulting = consultant
        specialty = department
        self.note = note
        super.init(person: person, notify: true, urgentLevel: urgency, notifyTime: NSDate() as Date)
    }
    
    override var description: String {
        return "\(personConsulting) from \(specialty) has met with \(person.description) in room \(person.roomNum)"
    }
    
    override var descriptionShort: String {
        return description
    }
    
    override var descriptionLong: String {
        var str = description
        str += " and they said \(note)"
        return str
    }
}
