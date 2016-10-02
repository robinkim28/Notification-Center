//: Playground - noun: a place where people can play

import UIKit




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
            toAdd.person.noteList.queue.append(toAdd);
            toAdd.person.noteList.queue.sort{ $0.timeToNotify < $1.timeToNotify };

        case .orderedDescending    :
            notificationsNewDate.append(toAdd);
            notificationsNewUrgency.append(toAdd);
            notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            toAdd.person.noteList.notificationsNewDate.append(toAdd)
            toAdd.person.noteList.notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
        case .orderedSame          :
            notificationsNewDate.append(toAdd);
            notificationsNewUrgency.append(toAdd);
            notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            toAdd.person.noteList.notificationsNewDate.append(toAdd)
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
                queue.filter{$0 != note}
                note.person.noteList.queue.filter{$0 != note}
                queue.sort{ $0.timeToNotify < $1.timeToNotify };
                
                notificationsNewDate.append(note);
                notificationsNewUrgency.append(note);
                notificationsNewUrgency.sort { $0.urgency.rawValue == $1.urgency.rawValue ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
                notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
               
                
                note.person.noteList.notificationsNewDate.sort { $0.urgency == $1.urgency ? $0.timeToNotify < $1.timeToNotify : $0.urgency.rawValue < $1.urgency.rawValue };
            case .orderedSame          :
                queue.filter{$0 != note}
                note.person.noteList.queue.filter{$0 != note}
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

class Notification: CustomStringConvertible, Equatable {
    enum UrgencyLevels: Int{
        case red = 0, yellow, green
    }
    
    let urgency: UrgencyLevels
    let subscribe: Bool
    let done: Bool
    
    let dateAndTimeCreated:NSDate = NSDate()
    let timeToNotify: Date
    
    let person: Patient
    
    init(person: Patient, notify: Bool, urgentLevel: UrgencyLevels, notifyTime: Date){
        self.person = person
        subscribe = notify
        urgency = urgentLevel
        done = false
        timeToNotify = notifyTime
    }
    
    var description: String {
        return "\(person.description) needs care in room \(person.roomNum)"
    }
    
    var descriptionLong: String {
        return description
    }
    
    var descriptionShort: String {
        return description
    }
    static func ==(left: Notification, right: Notification) -> Bool {
        return left.dateAndTimeCreated == right.dateAndTimeCreated
    }
}
class Lab: Notification{
    let type: String
    let result: String
    
    init(person: Patient, urgency: UrgencyLevels, testType: String, testResult: String){
        type = testType
        result = testResult
        super.init(person: person, notify: true, urgentLevel: urgency, notifyTime: NSDate() as Date)
    }
    
    override var description: String {
        return "The \(type) test for \(person.description) in room \(person.roomNum) came back"
    }
    
    override var descriptionShort: String {
        return description
    }
    
    override var descriptionLong: String {
        var str = description
        str += " with the results of \(result)"
        return str
    }
}
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
class Consultant: Notification{
    let personConsulting: String
    let specialty: String
    let note: String
    
    init(person: Patient, urgency: UrgencyLevels, consultant: String, department: String, note: String){
        personConsulting = consultant
        specialty = department
        self.note = note
        super.init(person: person, notify: true, urgentLevel: urgency, notifyTime: NSDate() as Date)
    }
    
    override var description: String {
        return "\(personConsulting) from \(specialty) has met with \(person.description) in room \(person.roomNum)"
    }
    
    override var descriptionShort: String {
        return description
    }
    
    override var descriptionLong: String {
        var str = description
        str += " and they said \(note)"
        return str
    }
}
class Prescription: Notification{
    let dosage: Double
    let medicine: String
    
    var dateAndTimeNext: Date
    let calendar = Calendar.current
    var date: Date
    
    var repeatNum: Int
    let repeatTimeHour: Int
    let repeatTimeMinute: Int
    
    init(person: Patient, urgency: UrgencyLevels, numRepeat: Int, repeatHour: Int, repeatMinute: Int, dosage: Double, medicine: String){
        repeatNum = numRepeat
        repeatTimeHour = repeatHour
        repeatTimeMinute = repeatMinute
        self.dosage = dosage
        self.medicine = medicine
        date = calendar.date(byAdding: .hour, value: repeatTimeHour, to: NSDate() as Date)!
        date = calendar.date(byAdding: .minute, value: repeatTimeMinute, to: date)!
        dateAndTimeNext =  date
        super.init(person: person, notify: true, urgentLevel: urgency, notifyTime: dateAndTimeNext)
    }
    
    init(copyFrom: Prescription){
        repeatNum = copyFrom.repeatNum - 1
        repeatTimeHour = copyFrom.repeatTimeHour
        repeatTimeMinute = copyFrom.repeatTimeMinute
        self.dosage = copyFrom.dosage
        self.medicine = copyFrom.medicine
        date = calendar.date(byAdding: .hour, value: repeatTimeHour, to: copyFrom.dateAndTimeNext as Date)!
        date = calendar.date(byAdding: .minute, value: repeatTimeMinute, to: date)!
        dateAndTimeNext =  date
        super.init(person: copyFrom.person, notify: true, urgentLevel: copyFrom.urgency, notifyTime: dateAndTimeNext)
    }
    
    override var description: String {
        return "\(person.description) in room \(person.roomNum) needs an order of \(dosage) mg of \(medicine)"
    }
    
    override var descriptionShort: String {
        return description
    }
    
    override var descriptionLong: String {
        return description
    }
}
class Patient: CustomStringConvertible{
    let lastName: String;
    let firstName: String;
    let age: Int;
    let roomNum: String;
    var noteList: NotificationList;
    
    // date format should be in "yyyy-MM-dd" when passing in
    init(lastName: String, firstName: String, age: Int, roomNum: String){
        
        self.lastName = lastName;
        self.firstName = firstName;
        self.age = age;
        
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

print("--------------------------------")

var note1 = Prescription(person: matt, urgency: .red, numRepeat: 0, repeatHour: 0, repeatMinute: 0, dosage: 0.2, medicine: "Tylenol")
var note2 = Prescription(person: robin, urgency: .green, numRepeat: 1, repeatHour: 0, repeatMinute: 1, dosage: 0.2, medicine: "Advil")
var note3 = Lab(person: lilly, urgency: .yellow, testType: "bark", testResult: "passed")
var note4 = Consultant(person: nash, urgency: .red , consultant: "Barry Lawson", department: "Richmond", note: "All good")

var notList = NotificationList()

notList.add(toAdd: note1)
notList.add(toAdd: note2)
notList.add(toAdd: note3)
notList.add(toAdd: note4)

notList.print()
print("--------------------------------")
theList.print()
print("--------------------------------")
print("--------------------------------")
sleep(61)
print("I am awake1-----********")
notList.refresh()
notList.print()
print("--------------------------------")
theList.print()

print("--------------------------------")
print("--------------------------------")
sleep(61)
print("I am awake2----*********")
notList.refresh()
notList.print()
print("--------------------------------")
theList.print()



