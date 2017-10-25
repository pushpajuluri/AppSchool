//
//  TimeLineAssignTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 9/5/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TimeLineAssignTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblAssgn: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
