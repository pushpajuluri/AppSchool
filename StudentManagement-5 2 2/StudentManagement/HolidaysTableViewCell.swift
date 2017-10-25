//
//  HolidaysTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/22/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class HolidaysTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblFrm: UILabel!
    @IBOutlet weak var lblOccasion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
