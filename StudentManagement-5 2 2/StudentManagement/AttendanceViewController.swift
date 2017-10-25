//
//  AttendanceViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 7/24/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit
import Material
import Foundation


class AttendanceViewController:UIViewController, UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource {
    var studentArray =  [StudentModel]()
   
    var techerSelectedClass:TeacherMySubject!
    var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
   
    
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnViewAttendence: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    var teacherSubArray = [TeacherMySubject]()
    //var list = ["1", "2", "3"]
    
    @IBAction func btnSaveAttendence(_ sender: UIButton) {
        
        //Prepare body
        var bodyArray = [[String:Any]]()
        for i in 0..<self.studentArray.count {
            let selectedObj = self.studentArray[i]
            
            let aDict =  ["id":techerSelectedClass.id,"name":selectedObj.name ?? "","attendancestatus":self.boolToString(value: selectedObj.isPresent),"dateofattendance":date(),"gradeid":techerSelectedClass.gradeid,"sectionname":techerSelectedClass.sectionname,"classroomid":selectedObj.id ?? ""] as [String : Any]
            bodyArray.append(aDict)
        }
       
        ApiHelper.sharedController().callToSaveAttendence(bodyArray: bodyArray,successblock: { (todayResult) in
            let message = todayResult!["message"]
            self.showToast(message:  (message as! String))
            print("attendence are saved  response \(todayResult!)")

        },FailureBlock: nil, viewController: self)

        
    }
        
        
//    var alertarray = [[String:Any]]()
//    alertGrade = [AlertModel(title:String(techerSelectedSubject.gradeid),techerSelectedSubject.sectionname]
//    for i in 0..<self.alertGrade.count
//    {
//    let alert =
//    }
//    
//    
//    
//    self.showAlertView1(title: <#T##String#>, messsage: <#T##String#>, alertModelArray: <#T##[AlertModel]?#>) { (selected) -> Void? in
//    return nil;

    

        // picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
            return teacherSubArray.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            self.view.endEditing(true)
            let classname = teacherSubArray[row];
            return String(classname.gradenumber)+classname.sectionname
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
             self.dropDown.isHidden = true
             todayAttendenceOfStudent(techerSelectedClassValue: teacherSubArray[row])
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            
            if textField == self.textBox {
                self.dropDown.isHidden = false
                 textField.endEditing(true)
            }
            
        }

//     ApiHelper.sharedController().callToSaveAttendence(bodyArray: bodyArray,successblock: { (todayResult) in
//            print("attendence are saved  response \(todayResult!)")
//        },FailureBlock: nil, viewController: self)
    
    
    
    func boolToString(value: Bool?) -> String {
        if  value==true {
            return "1"
        }
        else {
            return "0"
        }
    }
    
    
    @IBOutlet weak var btnSaveAttendence: UIButton!
    //Date
    func date() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        let result = formatter.string(from: date)
        return result
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getMysubjects()
        self.hideKeyboardWhenTappedAround()
      //  dropDown.dataSource = self
      //  dropDown.delegate = self
        dropDown.reloadAllComponents()
       
        tapGesture.numberOfTapsRequired = 1
        lblClass.addGestureRecognizer(tapGesture)
        lblClass.isUserInteractionEnabled = true
        tapGesture.addTarget(self, action: #selector( tempMethod))
        dropDown.isHidden=true
    }

    func  tempMethod(){
    
        dropDown.isHidden = false
//        var alertmodelarray = [AlertModel]()
//        for object in self.teacherSubArray {
//            
//            alertmodelarray.append(AlertModel.init(title: String(object.gradeid)+object.sectionname))
//         }
//         self.showAlertView1(title: "test", messsage: "message", alertModelArray: alertmodelarray) { (AlertModel) -> Void? in
//        
//            return nil;
//        }
    }//API call for getting subjects
    func getMysubjects() {
        ApiHelper.sharedController().callToGetMysubjectsForClass(successblock: { (todayResultMySubjects) in
            print("success")
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            for dict in myNewDictArray{
                self.teacherSubArray.append(TeacherMySubject.parseData(dict: dict))
            }
            
            if(self.teacherSubArray.count>0){
                 self.todayAttendenceOfStudent(techerSelectedClassValue: self.teacherSubArray.first!);
                self.dropDown.reloadAllComponents()
            }
        },FailureBlock: nil,viewController: self)
    }

    
    //Api Call for getting students list for attendence
    func todayAttendenceOfStudent(techerSelectedClassValue:TeacherMySubject)  {
        
       techerSelectedClass = techerSelectedClassValue
         self.lblClass.text = "Class:" + String(techerSelectedClass.gradenumber)+techerSelectedClass.sectionname;

        self.studentArray.removeAll()
        ApiHelper.sharedController().callToGetAttendence(techerSelectedSubject: techerSelectedClass,successblock: { (Result) in
            print("Get attendence response \(Result)")
            let  myNewDictArray = Result?.value(forKey: "studentsOfClassRoom")  as! Array<AnyObject>
            for dict in myNewDictArray {
                self.studentArray.append(StudentModel.parseData(dict: dict as! Dictionary<String, Any>))
            }
          DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }, FailureBlock: nil, viewController: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return studentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!  AttendenceCell
        let  studentObj = self.studentArray[indexPath.row]
        
        cell.lblStudent.text = studentObj.name?.capitalized
        cell.lblId.text = "Id :"+String(studentObj.id)
        cell.lblId.tintColor = UIColor.red
        
        cell.switchAttendence.tag = indexPath.row
        cell.imgStdnt.image = UIImage(named:"student.png")
        cell.switchAttendence.addTarget(self, action: #selector(switchChanged(sender:)), for: UIControlEvents.valueChanged)
        
        if(studentObj.isPresent == true)
        {
            cell.switchAttendence.isOn = true
        }
        else{
            cell.switchAttendence.isOn = false
        }
        return cell
    }
    
    
    
    func switchChanged(sender: UISwitch!) {
        let  studentObj = self.studentArray[sender.tag]
        
        if(sender.isOn == true)
        {
            studentObj.isPresent = true
        }
        else{
            studentObj.isPresent = false
        }
        self.myTableView.reloadData()
    }
    
}


