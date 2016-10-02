//: Playground - noun: a place where people can play

import UIKit

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

class Notification: CustomStringConvertible{
    enum UrgencyLevels: Int{
        case red = 0, yellow, green
    }
    
    static var indexTotal = 0
    let indexDat: Int
    let urgency: UrgencyLevels
    let subscribe: Bool
    let done: Bool
    
    let dateAndTimeCreated:NSDate = NSDate()
    let timeToNotify: Date
    
    //let person: Patient
    
    //init(person: Patient, notifiy: Bool, urgentLevelSpecified: UrgencyLevels){
    init(notify: Bool, urgentLevel: UrgencyLevels, notifyTime: Date){
        //self.person = person
        subscribe = notify
        urgency = urgentLevel
        done = false
        timeToNotify = notifyTime
        Notification.indexTotal = Notification.indexTotal + 1
        indexDat = Notification.indexTotal
        
    }
    
    var description: String {
        return "Nasheya Rahman \(indexDat) \(urgency)"
    }
}

class NotificationList{
    
    var notificationsNewUrgency = [Notification]()
    var notificationsNewDate = [Notification]()
    var queue = [Notification]()
    var notificationsOld = [Notification]()
    
    func add(toAdd: Notification){
        //notificationsNewUrgency.append(toAdd)
        //notificationsNewDate.append(toAdd)
        
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
        case .orderedSame          :
            notificationsNewDate.append(toAdd);
            notificationsNewUrgency.append(toAdd);
            notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
        }
    
    //DO A FUNCTION THAT CHECKS EVERY FEW SECONDS FROM THE QUEUE AND INSERTS IT INTO THE ARRAYS USING THAT INSERT FUNCTION
        // use this line to keep refreshing:
        //  var timer = NSTimer.scheduledTimerWithTimeInterval(60(//in sec//), target: self, selector: Selector("function" //<- function name//), userInfo: nil, repeats: true)

        func refresh(){
            for note in queue{
                switch NSDate().compare(note.timeToNotify) {
                case .orderedDescending    :
                    queue.filter() {$0 != note}
                    queue.sort{ $0.timeToNotify < $1.timeToNotify };
                    notificationsNewDate.append(note);
                    notificationsNewUrgency.append(note);
                    notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
                    notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
                case .orderedSame          :
                    queue.filter() {$0 != note}
                    queue.sort{ $0.timeToNotify < $1.timeToNotify };
                    notificationsNewDate.append(note);
                    notificationsNewUrgency.append(note);
                    notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
                    notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
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
