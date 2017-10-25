//
//  AddSectionViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 6/5/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class AddSectionViewController: UIViewController {

    var selectedClassObject:Classes!
    @IBOutlet var txtSectionName:UITextField!
    override func viewDidLoad() {
        self.title = "Add Section"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(AddSectionViewController.submitTapped))
        super.viewDidLoad()
   

        // Do any additional setup after loading the view.
    }
    func submitTapped()
    {
        if self.txtSectionName.text != "" {
            let status =  DataBaseHelper.sharedController().addSectionToClass(classObject: self.selectedClassObject, sectionName: self.txtSectionName.text!)
            print("section added status : \(status)")
        }

         txtSectionName.text = nil
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
