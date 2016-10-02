//
//  PatientList.swift
//  healthhack2016
//
//  Created by Robin Kim on 10/1/16.
//  Copyright © 2016 Robin Kim. All rights reserved.
//

import Foundation

class PatientList{
    var patientList = [Patient]();
    
    init() {
        patientList = [Patient]();
    }
    
    func add(newPatient: Patient){
        self.patientList.append(newPatient);
        patientList.sort{ $0.lastName < $1.lastName};
    }
    func print(){
        dump(self)
    }
    
    
}
