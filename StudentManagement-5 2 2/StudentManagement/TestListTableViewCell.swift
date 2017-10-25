//
//  TestListTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/19/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TestListTableViewCell: UITableViewCell {

    @IBOutlet weak var btnEditSyllabus: UIButton!
    
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var syllabusView: UIView!
    @IBOutlet weak var txtSyllabuc: UITextField!
   // @IBOutlet weak var txtSyllabuc: UITextView!
    @IBOutlet weak var btnAddMarks: UIButton!
    @IBOutlet weak var lblMaxMarks: UILabel!
    @IBOutlet weak var lblEnddate: UILabel!
    @IBOutlet weak var lblTestMode: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblSyllabus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
