//
//  EventsTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/22/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblGuest: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    @IBOutlet weak var lbleventDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
