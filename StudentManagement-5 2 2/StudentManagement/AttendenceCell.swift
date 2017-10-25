//
//  AttendenceCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/2/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class AttendenceCell: UITableViewCell {
    
   
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblStudent: UILabel!
    @IBOutlet weak var imgStdnt: UIImageView!
    
    @IBOutlet weak var switchAttendence: UISwitch!
    
      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
