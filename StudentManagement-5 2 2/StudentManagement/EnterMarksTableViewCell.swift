//
//  EnterMarksTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/22/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class EnterMarksTableViewCell: UITableViewCell {

    @IBOutlet weak var txtObt: UITextField!
    @IBOutlet weak var txtMax: UITextField!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
