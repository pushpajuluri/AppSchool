//
//  AssignmentTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/23/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var lblDueDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblAssignment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
