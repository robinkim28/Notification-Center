//
//  PatientNotificationViewController.swift
//  HealthHack NotificationCenter
//
//  Created by Matt Santa on 10/2/16.
//  Copyright © 2016 Matt Santa. All rights reserved.
//

import UIKit

class PatientNotificationViewController: UITableViewController {

    var notificationsNew: [Notification]!
    var notificationsOld: [Notification]!
    var patient: Patient!

    
    override func viewWillAppear(_ animated: Bool) {
        notificationsNew = patient.noteList.notificationsNewDate
        notificationsOld = patient.noteList.notificationsOld
        
        tableView!.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 75
        
        let cell: CustomNotificationTableCell = tableView.dequeueReusableCell(withIdentifier: "CustomNotificationTableCell") as! CustomNotificationTableCell
        
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(NotificationTableViewController.completeNotification(_:)), for: UIControlEvents.allTouchEvents)
        
        
        if ((indexPath as NSIndexPath).row < notificationsNew.count) {
            // Setting the cell text
            cell.descriptionLabel!.text = self.notificationsNew[(indexPath as NSIndexPath).row].descriptionLong
            
            // Setting button title for cell
            var title: String
            if (notificationsNew[(indexPath as NSIndexPath).row].done == true) {
                title = "Done"
            } else {
                title = "Not done"
            }
            
            cell.checkButton.setTitle(title, for: UIControlState.normal)
            
        } else if ((indexPath as NSIndexPath).row == notificationsNew.count) {
            
            cell.descriptionLabel!.text = " "
            cell.checkButton.isHidden = true
        
            
        } else {
            cell.descriptionLabel!.text = self.notificationsOld[(indexPath as NSIndexPath).row - notificationsNew.count + 1].descriptionLong
            
            var title: String
            if (notificationsOld[(indexPath as NSIndexPath).row - notificationsNew.count + 1].done == true) {
                title = "Done"
            } else {
                title = "Not done"
            }
            
            cell.checkButton.setTitle(title, for: UIControlState.normal)
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (notificationsNew.count + notificationsOld.count + 1)
    }
    
    @IBAction func completeNotification(_ sender: AnyObject) {
        let index = sender.tag
        
        if (index! < notificationsNew.count) {
            (UIApplication.shared.delegate as! AppDelegate).notifications.checked(toRemove: notificationsNew[index!])
        } else {
            (UIApplication.shared.delegate as! AppDelegate).notifications.checked(toRemove: notificationsOld[index! - notificationsNew.count - 1])
        }
        
        tableView.reloadData()
    }

    


}
