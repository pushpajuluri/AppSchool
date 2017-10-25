//
//  AddLessonViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/14/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class AddLessonViewController: UIViewController {

    
   
    
    @IBOutlet weak var txtLesName: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtTag: UITextField!
    @IBOutlet weak var txtStatus: UITextView!
     var  datepicker = UIDatePicker()
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
    }
    //Add Lesson
   
    @IBAction func btnAddLssn(_ sender: Any) {
        let body =  ["id":SharedClass.sharedInstance.teacherSelectedSubject.id,"lessondescription":self.txtTag.text!,"lessonstartdate":datePickerChanged(sender: datepicker),"subjectname":SharedClass.sharedInstance.teacherSelectedSubject.subjectname ,"lessonname":self.txtLesName.text!,"status":self.txtStatus.text] as [String : Any]
       // call to add lesson
        
        ApiHelper.sharedController().callToAddLesson(bodyArray: body,successblock: { (Result) in
            let message = Result!["message"]
            self.showToast(message:  (message as! String))
            print("lesson are saved  response \(Result!)")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let testViewController = storyboard.instantiateViewController(withIdentifier: "MasterViewController") as! MasterViewController
            self.navigationController?.pushViewController(testViewController, animated: true)
        },FailureBlock: nil, viewController: self)
    }
    @IBOutlet weak var btnAddLssn: UIButton!
    
    //date picker
    func closeKeyBoard() {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing( _ textField: UITextField) {
       
        txtDate.inputView = datepicker
        datepicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
    }
    
    func datePickerChanged(sender: UIDatePicker) -> Double{
        let formatter = DateFormatter ()
        formatter.dateFormat = "yyyy-MM-dd"
        txtDate.text = formatter.string (from: sender.date)
        return  datepicker.date.timeIntervalSince1970*(1000)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyBoard()
    }
    
    
  

}
