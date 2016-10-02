//
//  main.swift
//  HealthHacks
//
//  Created by Nasheya Rahman on 10/1/16.
//  Copyright © 2016 Nasheya Rahman. All rights reserved.
//

import Foundation

var notes = NotificationList()
var nash = Patient(lastName: "Rahman", firstName: "Nasheya", age: 20, roomNum: "ER 120")
var blah = PatientList()
blah.add(newPatient: nash)
notes.add(toAdd:Prescription(person: nash, urgency: .red, numRepeat: 5, repeatHour: 0, repeatMinute: 1, dosage: 0.3, medicine: "Advil"))
notes.print()
blah.print()
print("*********************************")
print("*********************************")
print("*********************************")
print("*********************************")
sleep(80)
notes.refresh()
notes.print()
blah.print()
//notes.add(toAdd:Notification(notify: false,urgentLevel: .yellow, notifyTime: NSDate() as Date))
//print(notes.notificationsNewUrgency[1].descriptionLong)
//notes.checked(toRemove:notes.notificationsNewUrgency[1])
