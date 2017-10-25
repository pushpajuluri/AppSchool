//
//  ViewMarksTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 9/20/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class ViewMarksTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMrks: UILabel!
    @IBOutlet weak var lblSubName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
