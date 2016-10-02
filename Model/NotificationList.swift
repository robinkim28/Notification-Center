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
        //notificationsNewUrgency.append(toAdd)
        //notificationsNewDate.append(toAdd)
        
        //if the time is later, add it to the notifications queue IN ORDER
        
        //if the time is now, implement this insert function
        //insert(toAdd: toAdd)
    }
    
    func insert(toAdd: Notification){
        // add a notification to both the date and urgency lists by insertion sort
        //basically sorting it as you go
        
        /*for note in notificationsNewUrgency {
         if note.urgency.rawValue < toAdd.urgency.rawValue {
         
         }
         
         }*/
    }
    
    //DO A FUNCTION THAT CHECKS EVERY FEW SECONDS FROM THE QUEUE AND INSERTS IT INTO THE
    //ARRAYS USING THAT INSERT FUNCTION
    
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
            if toRemove is Prescription{
                if (toRemove as! Prescription).repeatNum != 0 {
                    
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
        }
        
    }
    
    func printArrays(){
        for note in notificationsNewUrgency{
            print(note)
        }
        
        for note in notificationsNewDate{
            print(note)
        }
    }
    
}
