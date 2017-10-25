//
//  AddClassViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 6/1/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class AddClassViewController: UIViewController {
    @IBOutlet weak var txtClassName: UITextField!
    @IBOutlet weak var txtNofS: UITextField!
    @IBAction func Tests(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selViewController = storyboard.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        
        //Prepare array
        var datArray4 = [SelectionModel]()
        
        let selectObj = SelectionModel()
        selectObj.option = "Test 1"
        datArray4.append(selectObj)
        
        let selectObj1 = SelectionModel()
        selectObj1.option = "Test 2"
        datArray4.append(selectObj1)
        
        let selectObj2 = SelectionModel()
        selectObj2.option = "quarterly "
        datArray4.append(selectObj2)
        
        let selectObj3 = SelectionModel()
        selectObj3.option = "Half yearly exam"
        datArray4.append(selectObj3)
        
        let selectObj4 = SelectionModel()
        selectObj4.option = "Final "
        datArray4.append(selectObj4)

        
        selViewController.selectionArray = datArray4
        self.navigationController?.pushViewController(selViewController, animated: true)
    }
    @IBAction func teachers(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selViewController = storyboard.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        
        //Prepare array
        var datArray3 = [SelectionModel]()
        
        let selectObj = SelectionModel()
        selectObj.option = "tejaswini"
        datArray3.append(selectObj)
        
        let selectObj1 = SelectionModel()
        selectObj1.option = "rahul"
        datArray3.append(selectObj1)
        
        let selectObj2 = SelectionModel()
        selectObj2.option = "abhinav"
        datArray3.append(selectObj2)
        
        let selectObj3 = SelectionModel()
        selectObj3.option = "ramesh"
        datArray3.append(selectObj3)
        
        let selectObj4 = SelectionModel()
        selectObj4.option = "dariya"
        datArray3.append(selectObj4)
        
        let selectObj5 = SelectionModel()
        selectObj5.option = "lakshmi"
        datArray3.append(selectObj5)
        
        let selectObj6 = SelectionModel()
        selectObj6.option = "mahender"
        datArray3.append(selectObj6)
        
        selViewController.selectionArray = datArray3
        self.navigationController?.pushViewController(selViewController, animated: true)
    }
    @IBAction func syllabus(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selViewController = storyboard.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        
        //Prepare array
        var datArray2 = [SelectionModel]()
        
        let selectObj = SelectionModel()
        selectObj.option = "CBSE"
        datArray2.append(selectObj)
        
        let selectObj1 = SelectionModel()
        selectObj1.option = "State"
        datArray2.append(selectObj1)
        
        let selectObj2 = SelectionModel()
        selectObj2.option = "ICSE"
        datArray2.append(selectObj2)
        
        selViewController.selectionArray = datArray2
        self.navigationController?.pushViewController(selViewController, animated: true)
           }
    @IBAction func Labs(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selViewController = storyboard.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        
        //Prepare array
        var datArray1 = [SelectionModel]()
        
        let selectObj = SelectionModel()
        selectObj.option = "physics lab"
        datArray1.append(selectObj)
        
        let selectObj1 = SelectionModel()
        selectObj1.option = "chemistry lab"
        datArray1.append(selectObj1)
        
        let selectObj2 = SelectionModel()
        selectObj2.option = "Communication lab"
        datArray1.append(selectObj2)

        selViewController.selectionArray = datArray1
        self.navigationController?.pushViewController(selViewController, animated: true)

        
    }
    @IBAction func subjects(_ sender: UIButton) {
        /* let alertView = UIAlertView(title: "Please select your subjects", message: "      ", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
        alertView.show() */
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selViewController = storyboard.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        
        //Prepare array
        var datArray = [SelectionModel]()
      
        let selectObj = SelectionModel()
        selectObj.option = "Maths"
        datArray.append(selectObj)
        
        let selectObj1 = SelectionModel()
        selectObj1.option = "Physics"
        datArray.append(selectObj1)
        
        let selectObj2 = SelectionModel()
        selectObj2.option = "Chemistry"
        datArray.append(selectObj2)

        
        let selectObj3 = SelectionModel()
        selectObj3.option = "Social Studies"
        datArray.append(selectObj3)

        
        let selectObj4 = SelectionModel()
        selectObj4.option = "Telugu"
        datArray.append(selectObj4)

        
        let selectObj5 = SelectionModel()
        selectObj5.option = "Hindi"
        datArray.append(selectObj5)
        
        let selectObj6 = SelectionModel()
        selectObj6.option = "English"
        datArray.append(selectObj6)

        
    selViewController.selectionArray = datArray
        self.navigationController?.pushViewController(selViewController, animated: true)
        
        

    }
    override func viewDidLoad() {
        self.title = "Add Class"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(AddClassViewController.submitTapped))

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func submitTapped()
    {
        if self.txtClassName.text != "" && self.txtNofS.text != "" {

            let status =  DataBaseHelper.sharedController().addClassRoom(className: self.txtClassName.text!,totalStudents: self.txtNofS.text!)
            print("class added status : \(status)")
            
            
        }
        //emptying the data
        txtClassName.text = nil
        txtNofS.text = nil
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
