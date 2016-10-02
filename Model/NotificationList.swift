//
//  NotificationList.swift
//  HealthHacks
//
//  Created by Nasheya Rahman on 10/1/16.
//  Copyright © 2016 Nasheya Rahman. All rights reserved.
//

import Foundation
class NotificationList{
    
    var notificationsNewUrgency = [Notification]()
    var notificationsNewDate = [Notification]()
    var queue = [Notification]()
    var notificationsOld = [Notification]()
    
    func add(toAdd: Notification){
        //if timetonotify is later, add it to the notifications queue IN ORDER
        //if timetonotify is now, insert(toAdd: toAdd)
        
        switch NSDate().compare(toAdd.timeToNotify) {
        case .orderedAscending     :
            queue.append(toAdd); queue.sort{ $0.timeToNotify < $1.timeToNotify };
        case .orderedDescending    :
            notificationsNewDate.append(toAdd);
            notificationsNewUrgency.append(toAdd);
            notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            toAdd.person.noteList.notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
        case .orderedSame          :
            notificationsNewDate.append(toAdd);
            notificationsNewUrgency.append(toAdd);
            notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            toAdd.person.noteList.notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
        }
    }
    
    //DO A FUNCTION THAT CHECKS EVERY FEW SECONDS FROM THE QUEUE AND INSERTS IT INTO THE ARRAYS USING THAT INSERT FUNCTION
    // use this line to keep refreshing:
    //  var timer = NSTimer.scheduledTimerWithTimeInterval(60(//in sec//), target: self, selector: Selector("function" //<- function name//), userInfo: nil, repeats: true)
    
    func refresh(){
        for note in queue{
            switch NSDate().compare(note.timeToNotify) {
            case .orderedAscending     : break
            case .orderedDescending    :
                queue.filter() {$0 != note}
                queue.sort{ $0.timeToNotify < $1.timeToNotify };
                notificationsNewDate.append(note);
                notificationsNewUrgency.append(note);
                notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
                notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
                note.person.noteList.notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            case .orderedSame          :
                queue.filter() {$0 != note}
                queue.sort{ $0.timeToNotify < $1.timeToNotify };
                notificationsNewDate.append(note);
                notificationsNewUrgency.append(note);
                notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
                notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
                note.person.noteList.notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            }
        }
    }
    
    func checked(toRemove: Notification){
        //removes in urgency notifications array
        var index = 0
        for note in notificationsNewUrgency {
            if toRemove !== note {
                index = index + 1
            } else {
                break
            }
        }
        
        if index < notificationsNewUrgency.count {
            notificationsNewUrgency.remove(at: index)
            
            //add new Prescription thing if needed
            if toRemove is Prescription{
                if (toRemove as! Prescription).repeatNum != 0 {
                    add(toAdd: Prescription(copyFrom: toRemove as! Prescription))
                }
            }
        }
        
        //removes in date notifications array
        index = 0
        for note in notificationsNewDate {
            if toRemove !== note {
                index = index + 1
            } else {
                break
            }
        }
        
        if index < notificationsNewDate.count {
            notificationsNewDate.remove(at: index)
            
            //add new Prescription thing if needed
            if toRemove is Prescription{
                if (toRemove as! Prescription).repeatNum != 0 {
                    add(toAdd: Prescription(copyFrom: toRemove as! Prescription))
                }
            }
        }
        
    }
    func print(){
        dump(self)
    }
}
