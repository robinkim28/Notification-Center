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
        if(toAdd.subscribe){
            if toAdd is Prescription {
                if (toAdd as! Prescription).repeatNum > 0 {
                    let stop = (toAdd as! Prescription).repeatNum
                    var temp = toAdd
                    for _ in 1...stop {
                        queue.append(temp)
                        queue.sort{ $0.timeToNotify < $1.timeToNotify }
                        temp.person.noteList.queue.append(temp)
                        temp.person.noteList.queue.sort{ $0.timeToNotify < $1.timeToNotify }
                        temp = Prescription(copyFrom: (temp as! Prescription))
                    }
                }
            } else {
                notificationsNewDate.append(toAdd)
                notificationsNewUrgency.append(toAdd)
                
                notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue }
                notificationsNewDate.sort { $0.timeToNotify > $1.timeToNotify }
                
                toAdd.person.noteList.notificationsNewDate.append(toAdd)
                toAdd.person.noteList.notificationsNewDate.sort { $0.timeToNotify > $1.timeToNotify }
            }
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
                queue.remove(at: 0)
                note.person.noteList.queue.remove(at: 0)
                queue.sort{ $0.timeToNotify < $1.timeToNotify };
                
                notificationsNewDate.append(note);
                notificationsNewUrgency.append(note);
                notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
                notificationsNewDate.sort { $0.timeToNotify > $1.timeToNotify };
                
                note.person.noteList.notificationsNewDate.append(note)
                note.person.noteList.notificationsNewDate.sort { $0.timeToNotify > $1.timeToNotify };
            case .orderedSame          :
                queue.remove(at: 0)
                note.person.noteList.queue.remove(at: 0)
                queue.sort{ $0.timeToNotify < $1.timeToNotify };
                
                notificationsNewDate.append(note);
                notificationsNewUrgency.append(note);
                notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
                notificationsNewDate.sort { $0.timeToNotify > $1.timeToNotify };
                
                note.person.noteList.notificationsNewDate.append(note)
                note.person.noteList.notificationsNewDate.sort { $0.timeToNotify > $1.timeToNotify };
            }
        }
    }
    
    public func checked(toRemove: Notification){
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
            notificationsOld.append(toRemove)
            notificationsOld.sort { $0.timeToNotify > $1.timeToNotify };
            
        }
        
        //removes in the patient's notifications array
        index = 0
        for note in toRemove.person.noteList.notificationsNewDate {
            if toRemove !== note {
                index = index + 1
            } else {
                break
            }
        }
        
        if index < toRemove.person.noteList.notificationsNewDate.count {
            toRemove.person.noteList.notificationsNewDate.remove(at: index)
            toRemove.person.noteList.notificationsOld.append(toRemove)
            toRemove.person.noteList.notificationsOld.sort { $0.timeToNotify > $1.timeToNotify };
        }
        
    }
    
    func print(){
        dump(self)
    }
}
