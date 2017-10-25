//
//  NewsTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/22/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblheadline: UILabel!
    @IBOutlet weak var lblreleasedate: UILabel!

    @IBOutlet weak var lbldescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
