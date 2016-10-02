//
//  Imaging.swift
//  HealthHacks
//
//  Created by Nasheya Rahman on 10/2/16.
//  Copyright © 2016 Nasheya Rahman. All rights reserved.
//

import Foundation
import UIKit

class Imaging: Notification{
    let image: UIImage
    let result: String
    
    init(person: Patient, urgency: UrgencyLevels, testResult: String, image: String){
        result = testResult
        self.image = UIImage(named: image)!
        super.init(person: person, notify: true, urgentLevel: urgency, notifyTime: NSDate() as Date)
    }
    
    override var description: String {
        return "The scan for \(person.description) in room \(person.roomNum) came back"
    }
    
    override var descriptionShort: String {
        return description
    }
    
    override var descriptionLong: String {
        return description
    }
}
