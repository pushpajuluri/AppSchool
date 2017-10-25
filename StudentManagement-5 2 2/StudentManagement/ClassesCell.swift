//
//  ClassesCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 6/6/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class ClassesCell: UITableViewCell {

    @IBOutlet weak var lblClassname: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBAction func Secname(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
