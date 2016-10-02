//
//  CustomPatientTableCell.swift
//  HealthHack NotificationCenter
//
//  Created by Matt Santa on 10/1/16.
//  Copyright © 2016 Matt Santa. All rights reserved.
//

import UIKit

class CustomPatientTableCell: UITableViewCell {
    

    @IBOutlet var firstName: UILabel!
    @IBOutlet var lastName: UILabel!
    @IBOutlet var age: UILabel!
    @IBOutlet var roomNumber: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
