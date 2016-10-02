//: Playground - noun: a place where people can play

import UIKit
class Patient: CustomStringConvertible{
    let lastName: String;
    let firstName: String;
    let age: Int;
    let roomNum: String;
    //let noteList: NotificationList;
    
    // date format should be in "yyyy-MM-dd" when passing in
    init(lastName: String, firstName: String, age: Int, roomNum: String /*noteList: NotificationList*/){
        
        self.lastName = lastName;
        self.firstName = firstName;
        self.age = age;
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd";
        
        self.roomNum = roomNum;
        //self.noteList = noteList;
        
    }
    var description: String{
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
}

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

var matt = Patient(lastName: "Santa", firstName: "Matt", age: 21, roomNum: "119E")
var nash = Patient(lastName: "Rahman", firstName: "Nasheya", age: 20, roomNum: "120D")
var robin = Patient(lastName: "Kim", firstName: "Robin", age: 23, roomNum: "134A")
var lilly = Patient(lastName: "McSilly", firstName: "Lilly", age: 12, roomNum: "10A")

print(matt)
print(nash)
print(robin)
print(lilly)

var theList = PatientList()
theList.add(newPatient: matt)
theList.add(newPatient: nash)
theList.add(newPatient: robin)
theList.add(newPatient: lilly)
theList.print()
