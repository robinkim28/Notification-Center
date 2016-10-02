//
//  main.swift
//  HealthHacks
//
//  Created by Nasheya Rahman on 10/1/16.
//  Copyright © 2016 Nasheya Rahman. All rights reserved.
//

import Foundation

var notes = NotificationList()
//notes.add(toAdd:Notification(notify: true, urgentLevel: .red))
//notes.add(toAdd:Notification(notify: false,urgentLevel: .yellow))
notes.printArrays()
notes.checked(toRemove:notes.notificationsNewUrgency[1])
notes.printArrays()
