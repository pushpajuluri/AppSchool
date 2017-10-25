//
//  WorkSheetTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/23/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class WorkSheetTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLink: UILabel!
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblLssnName: UILabel!
    @IBOutlet weak var lblWSName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
