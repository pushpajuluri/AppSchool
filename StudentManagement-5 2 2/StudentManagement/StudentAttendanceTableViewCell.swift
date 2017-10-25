//
//  StudentAttendanceTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 10/4/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class StudentAttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAttendanceStatus: UILabel!
    @IBOutlet weak var lblDateOfAttendance: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
