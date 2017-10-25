//
//  TimeLineCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/10/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TimeLineCell: UITableViewCell {

    @IBOutlet weak var btnPublish: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblLesson: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lbltag: UILabel!
    @IBOutlet weak var imgAssg: UIImageView!
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
