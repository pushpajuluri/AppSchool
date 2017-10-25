//
//  TimeLineWSTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 9/5/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TimeLineWSTableViewCell: UITableViewCell {
    @IBOutlet weak var lblWS: UILabel!
    @IBOutlet weak var lblLessName: UILabel!
    @IBOutlet weak var lblLink: UILabel!
    @IBOutlet weak var lblTag: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
