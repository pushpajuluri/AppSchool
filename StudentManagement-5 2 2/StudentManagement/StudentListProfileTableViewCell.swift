//
//  StudentListProfileTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 9/28/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class StudentListProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var viewint: UIView!
    @IBOutlet weak var lblInitial: UILabel!
    @IBOutlet weak var lblClassId: UILabel!
    @IBOutlet weak var lblFatherName: UILabel!
    @IBOutlet weak var lblAdmsnNo: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var initialTxt: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
