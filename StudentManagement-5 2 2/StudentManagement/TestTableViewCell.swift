//
//  TestTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 9/11/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    @IBOutlet weak var lblClss: UILabel!

    @IBOutlet weak var lblSub: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
