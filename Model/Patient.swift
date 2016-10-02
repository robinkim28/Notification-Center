//
//  Patient.swift
//  healthhack2016
//
//  Created by Robin Kim on 10/1/16.
//  Copyright © 2016 Robin Kim. All rights reserved.
//

import Foundation

class Patient: CustomStringConvertible{
    let lastName: String;
    let firstName: String;
    let age: String;
    let roomNum: String;
    var noteList: NotificationList;
    
    // date format should be in "yyyy-MM-dd" when passing in
    init(lastName: String, firstName: String, age: Int, roomNum: String){
        
        self.lastName = lastName;
        self.firstName = firstName;
        self.age = String(age);
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd";
        
        self.roomNum = roomNum;
        self.noteList = NotificationList();
        
    }
    var description: String{
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
}

