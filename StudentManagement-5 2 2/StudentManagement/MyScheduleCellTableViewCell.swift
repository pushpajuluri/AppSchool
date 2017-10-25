//
//  MyScheduleCellTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/1/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class MyScheduleCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTeacherSubj: UILabel!
    @IBOutlet weak var lblTeacherClass: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
