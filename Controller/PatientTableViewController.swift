//
//  PatientTableViewController.swift
//  HealthHack NotificationCenter
//
//  Created by Matt Santa on 10/1/16.
//  Copyright © 2016 Matt Santa. All rights reserved.
//

import UIKit

class PatientTableViewController: UITableViewController {

    var patients: [Patient]!
    var indexPathTemp: NSIndexPath!
    
    override func viewWillAppear(_ animated: Bool) {
        patients = (UIApplication.shared.delegate as! AppDelegate).patients.patientList
        
        tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 50
        
        let cell: CustomPatientTableCell = tableView.dequeueReusableCell(withIdentifier: "CustomPatientTableCell") as! CustomPatientTableCell
        
        // Setting the cell text
        cell.name.text = self.patients[(indexPath as NSIndexPath).row].firstName + " " + self.patients[(indexPath as NSIndexPath).row].lastName
        cell.age.text = "Age: " + self.patients[(indexPath as NSIndexPath).row].age
        cell.roomNumber.text = "Room: " + String(self.patients[(indexPath as NSIndexPath).row].roomNum)
        
        cell.name.sizeToFit()
        cell.age.sizeToFit()
        cell.roomNumber.sizeToFit()
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPathTemp = indexPath as NSIndexPath
        performSegue(withIdentifier: "PatientNotificationViewController", sender: UITableViewCell())
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let patientSpecificVC = segue.destination as! PatientNotificationViewController
        patientSpecificVC.patient = self.patients[(indexPathTemp as NSIndexPath).row]
    }
    
}
