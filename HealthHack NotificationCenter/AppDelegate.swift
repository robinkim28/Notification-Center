//
//  AppDelegate.swift
//  HealthHack NotificationCenter
//
//  Created by Matt Santa on 10/1/16.
//  Copyright © 2016 Matt Santa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Storing in a universal location
    var notifications = NotificationList()
    var patients = PatientList()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        var matt = Patient(lastName: "Santa", firstName: "Matt", age: 21, roomNum: "119E")
        var nash = Patient(lastName: "Rahman", firstName: "Nasheya", age: 20, roomNum: "120D")
        var robin = Patient(lastName: "Kim", firstName: "Robin", age: 23, roomNum: "134A")
        var lilly = Patient(lastName: "McSilly", firstName: "Lilly", age: 12, roomNum: "10A")
        
        print(matt)
        print(nash)
        print(robin)
        print(lilly)
        
        patients.add(newPatient: matt)
        patients.add(newPatient: nash)
        patients.add(newPatient: robin)
        patients.add(newPatient: lilly)
        patients.print()
        
        print("--------------------------------")
        
        
        var note1 = Consultant(person: nash, urgency: .red , consultant: "Billy Bob", department: "Richmond", note: "All good")
        var note2 = Consultant(person: nash, urgency: .red , consultant: "Jacob Jones", department: "Richmond", note: "All good")
        var note3 = Prescription(person: matt, urgency: .red, numRepeat: 2, repeatHour: 1, repeatMinute: 0, dosage: 0.2, medicine: "Tylenol")
        var note4 = Prescription(person: robin, urgency: .green, numRepeat: 3, repeatHour: 0, repeatMinute: 1, dosage: 0.2, medicine: "Advil")
        var note5 = Lab(person: lilly, urgency: .yellow, testType: "bark", testResult: "passed")
        var note6 = Consultant(person: nash, urgency: .red , consultant: "Barry Lawson", department: "Richmond", note: "All good")
        
        
        
        notifications.add(toAdd: note1)
        notifications.add(toAdd: note2)
        notifications.add(toAdd: note3)
        notifications.add(toAdd: note4)
        notifications.add(toAdd: note5)
        notifications.add(toAdd: note6)
        
        notifications.print()
        print("--------------------------------")
        patients.print()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

