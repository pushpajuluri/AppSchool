//
//  ChildSubjectsTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 9/21/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class ChildSubjectsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblSub: UILabel!

    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblSyll: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
