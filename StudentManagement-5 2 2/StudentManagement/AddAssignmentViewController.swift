//
//  AddAssignmentViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/14/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class AddAssignmentViewController: UIViewController{
    
    var lessonSubArray = [AddAssignmentModel]()
   
    
    
    func getCurrentMillis()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }



    @IBAction func btnSubmit(_ sender: UIButton) {
        let selectedTimeLine:String
        if(SharedClass.sharedInstance.techerSelectedTimeLine == nil){
                selectedTimeLine = ""
        }
        else{
            selectedTimeLine = SharedClass.sharedInstance.techerSelectedTimeLine.lessonname!
        }
        
        let body =  ["id":SharedClass.sharedInstance.teacherSelectedSubject.id,"assignmentname":self.txtAssName.text,"dateofassigned":getCurrentMillis(),"assignmentduedate":datePickerChanged(sender: datepicker),"subjectname":SharedClass.sharedInstance.teacherSelectedSubject.subjectname ,"lessonname":selectedTimeLine,"tags":self.txtAssTag.text] as [String : Any]
        // call to add lesson
        
        ApiHelper.sharedController().callToAddAssignment(bodyArray: body,successblock: { (Result) in
            let message = Result!["message"]
            self.showToast(message:  (message as! String))
            print("assignment are saved  response \(Result!)")
            
        },FailureBlock: nil, viewController: self)
    }

    
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtAssTag: UITextField!
    @IBOutlet weak var txtAssName: UITextField!
    @IBOutlet weak var txtLesn: UITextField!
    
    @IBOutlet weak var dropdown: UIPickerView!
    
    var datepicker : UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
  //getMylessons()
        // self.txtLesn.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        // Do any additional setup after loading the view.
    }

    
    
    //API call for getting lessons
    func getMylessons() {
        
       
        
        
        var body = ["id":SharedClass.sharedInstance.userid,"subjectname":SharedClass.sharedInstance.teacherSelectedSubject.subjectname] as [String : Any]
      
        
        ApiHelper.sharedController().callToGetLessonsList(bodyArray: body,successblock: { (Result) in
             print("got the lesson response \(Result!)")
            
              let  myNewDictArray = Result as? Array<Dictionary<String, Any>>
           
            for dict in myNewDictArray!{
                self.lessonSubArray.append(AddAssignmentModel.parseData(dict: dict))
                
            }
            
        },FailureBlock: nil, viewController: self)
    }
            override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //picker
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return lessonSubArray.count
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        self.view.endEditing(true)
//
//        let classname = lessonSubArray[row];
//        //    let selected = String(classname.gradeid)+classname.sectionname
//        return String(describing: classname.lessonname)
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        self.dropdown.isHidden = true
//       // let classname = lessonSubArray[row];
//      //  self.txtLesn.text = String(describing: classname.lessonname)
//
//    }
    
  
    func textFieldDidChange(_ textField:UITextField) {
      dropdown.isHidden = false
        
    }
    
  

    //date picker
    func closeKeyBoard() {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing( _ textField: UITextField) {
        txtDate.inputView = datepicker
        datepicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
//        if textField == self.txtLesn {
//            self.dropdown.isHidden = false
//            //if you dont want the users to se the keyboard type:
//            
//            textField.endEditing(true)
//        }
        

    }
    
    func datePickerChanged(sender: UIDatePicker) -> Double{
        let formatter = DateFormatter ()
        formatter.dateFormat = "yyyy-MM-dd"
        txtDate.text = formatter.string (from: sender.date)
        return datepicker.date.timeIntervalSince1970*(1000)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyBoard()
    }

}
