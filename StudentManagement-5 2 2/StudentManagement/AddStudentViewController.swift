//
//  AddStudentViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 6/8/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class AddStudentViewController: UIViewController {

    
    
    @IBOutlet weak var studentname: UITextField!
     var selectedStudentObject:Section?
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(AddStudentViewController.submitTapped))
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func submitTapped()
    {
        if self.studentname.text != "" {
            let status =  DataBaseHelper.sharedController().addStudent(sectionObject:selectedStudentObject!,studentName:self.studentname.text!)
            print("student added status : \(status)")
        }
        
        
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
