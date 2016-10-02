//
//  Prescription.swift
//  HealthHacks
//
//  Created by Nasheya Rahman on 10/1/16.
//  Copyright © 2016 Nasheya Rahman. All rights reserved.
//

import Foundation

class Prescription: Notification {
    let actionToBeTaken: Bool
    let dosage: Double
    let medicine: String
    
    var dateAndTimeNext: Date
    let calendar = Calendar.current
    var date: Date
    
    var repeatNum: Int
    let repeatTimeHour: Int
    let repeatTimeMinute: Int
    
    init(action: Bool, numRepeat: Int, repeatHour: Int, repeatMinute: Int, dosage: Double, medicine: String, urgency: UrgencyLevels){
        actionToBeTaken = action
        repeatNum = numRepeat
        repeatTimeHour = repeatHour
        repeatTimeMinute = repeatMinute
        self.dosage = dosage
        self.medicine = medicine
        date = calendar.date(byAdding: .hour, value: repeatTimeHour, to: NSDate() as Date)!
        date = calendar.date(byAdding: .minute, value: repeatTimeMinute, to: date)!
        dateAndTimeNext =  date
        super.init(notify: true, urgentLevel: urgency, notifyTime: dateAndTimeNext)
    }
    
    init(copyFrom: Prescription){
        repeatNum = copyFrom.repeatNum - 1
        actionToBeTaken = copyFrom.actionToBeTaken
        repeatTimeHour = copyFrom.repeatTimeHour
        repeatTimeMinute = copyFrom.repeatTimeMinute
        self.dosage = copyFrom.dosage
        self.medicine = copyFrom.medicine
        date = calendar.date(byAdding: .hour, value: repeatTimeHour, to: copyFrom.dateAndTimeNext as Date)!
        date = calendar.date(byAdding: .minute, value: repeatTimeMinute, to: date)!
        dateAndTimeNext =  date
        super.init(notify: true, urgentLevel: copyFrom.urgency, notifyTime: dateAndTimeNext)
    }
}
