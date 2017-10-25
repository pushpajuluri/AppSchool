//
//  ParentTestsTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 9/21/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class ParentTestsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTst: UILabel!

    @IBOutlet weak var btnViewRslt: UIButton!
    @IBOutlet weak var lblTstMode: UILabel!
    @IBOutlet weak var lblStrDate: UILabel!
    @IBOutlet weak var lblMaxMarks: UILabel!
    @IBOutlet weak var lblendDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
