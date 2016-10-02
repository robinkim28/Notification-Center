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
    
    override func viewWillAppear(_ animated: Bool) {
        patients = (UIApplication.shared.delegate as! AppDelegate).patients.patientList
        
        tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 200
        
        let cell: CustomPatientTableCell = tableView.dequeueReusableCell(withIdentifier: "CustomPatientTableCell") as! CustomPatientTableCell
        
        // Setting the cell text
        cell.firstName.text = self.patients[(indexPath as NSIndexPath).row].firstName
        cell.lastName.text = self.patients[(indexPath as NSIndexPath).row].lastName
        cell.age.text = "Age: " + self.patients[(indexPath as NSIndexPath).row].age
        cell.roomNumber.text = "Room: " + String(self.patients[(indexPath as NSIndexPath).row].roomNum)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }


}
