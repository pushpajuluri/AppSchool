//
//  TeacherTestViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/18/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TeacherTestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var testListArray =  [TestListModel]()
   var selectedTextField:UITextField!
    
    @IBOutlet weak var lblClassPicker: UIPickerView!
    var techerSelectedClass:TeacherMySubject!
   // var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
var parentSelectedClass:ChildMySubject!
    
    
  //  @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var textbox: UITextField!
    
    var teacherSubArray = [TeacherMySubject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
   // getMysubjects()
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
        if(SharedClass.sharedInstance.teacherSelectedSubject.subjectname == "Class Teacher")
        {
           TestListOfStudentofClass(techerSelectedClassValue: SharedClass.sharedInstance.teacherSelectedSubject)
        }
        else
        {
             TestListOfStudent(techerSelectedClassValue: SharedClass.sharedInstance.teacherSelectedSubject)
        }
        
//        lblClassPicker.reloadAllComponents()
//        
//        tapGesture.numberOfTapsRequired = 1
//        lblClass.addGestureRecognizer(tapGesture)
//        lblClass.isUserInteractionEnabled = true
       // tapGesture.addTarget(self, action: #selector( tempMethod))
        
      //  lblClassPicker.isHidden=true
        }
       
    }
    func  tempMethod(){
        
        lblClassPicker.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //API call for getting subjects
    func getMysubjects() {
        ApiHelper.sharedController().callToGetMysubjects(successblock: { (todayResultMySubjects) in
            print("success")
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            for dict in myNewDictArray{
                self.teacherSubArray.append(TeacherMySubject.parseData(dict: dict))
                //todayAttendenceOfStudent()
            }
            if(self.teacherSubArray.count>0){
                self.TestListOfStudent(techerSelectedClassValue: self.teacherSubArray.first!);
                self.lblClassPicker.reloadAllComponents()
                SharedClass.sharedInstance.teacherSelectedSubjectToAddmarks = self.teacherSubArray[0]
            }
        },FailureBlock: nil,viewController: self)
    }

            
            //Api Call for getting test list
            func TestListOfStudent(techerSelectedClassValue:TeacherMySubject)  {
                
                self.techerSelectedClass = techerSelectedClassValue
            //    self.lblClass.text = String(self.techerSelectedClass.gradenumber)+self.techerSelectedClass.sectionname;
                
                self.testListArray.removeAll()
                ApiHelper.sharedController().callToGetTestList(techerSelectedSubject: self.techerSelectedClass,successblock: { (Result) in
                    print("Get test list response of my subjects \(Result)")
                let  myNewDictArray = Result as! Array<Dictionary<String, Any>>
                    for dict in myNewDictArray{
                        self.testListArray.append(TestListModel.parseData(dict: dict))
                        }
                    
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
                }, FailureBlock: nil, viewController: self)
            }
    
    //Api Call for getting test list of class
    func TestListOfStudentofClass(techerSelectedClassValue:TeacherMySubject)  {
      self.testListArray.removeAll()
        ApiHelper.sharedController().callToGetTestListForClass(techerSelectedSubject: SharedClass.sharedInstance.teacherSelectedSubject,successblock: { (Result) in
            print("Get test list response of my class \(Result)")
            let  myNewDictArray = Result as! Array<Dictionary<String, Any>>
            for dict in myNewDictArray{
                self.testListArray.append(TestListModel.parseData(dict: dict))
            }
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }, FailureBlock: nil, viewController: self)
    }
    
   
    


    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1;
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
//        return teacherSubArray.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        self.view.endEditing(true)
//        let classname = teacherSubArray[row];
//        return String(classname.gradenumber)+classname.sectionname
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let classname =  teacherSubArray[row]
//        self.lblClassPicker.isHidden = true
//        TestListOfStudent(techerSelectedClassValue: teacherSubArray[row])
//        SharedClass.sharedInstance.teacherSelectedSubjectToAddmarks = classname
//    }
//    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
      //  if textField == self.textbox {
           // self.lblClassPicker.isHidden = false
          //  textField.endEditing(true)
    //    }
       
         let  selectedTestObj = self.testListArray[textField.tag]
        selectedTestObj.syllabus = textField.text
      //  print("textFieldDidEndEditing \(textField.text)")
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let txtfieldstr=textField.text?.appending(string)
         let  selectedTestObj = self.testListArray[textField.tag]
        selectedTestObj.syllabus  = txtfieldstr
        return true
    }
    
    
    public func textFieldDidBeginEditing(_ textField: UITextField){
        self.selectedTextField = textField
       // print("textFieldDidBeginEditing \(textField.text)")
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return true
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return testListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!  TestListTableViewCell
        let  testListObj = self.testListArray[indexPath.row]
        
               
        cell.lblSyllabus.text = testListObj.testtype
        cell.lblStartDate.text = "Start Date :"+testListObj.startdate!
        cell.lblEnddate.text = "end date : " + testListObj.enddate!
        if(testListObj.maxmarks != nil)
        {
        cell.lblMaxMarks.text = "Max Marks : "+String(testListObj.maxmarks)
        }
        else{
            cell.lblMaxMarks.text = "0"
        }
        cell.lblTestMode.text = "Test Mode : " + testListObj.testmode!
        
        cell.btnAddMarks.addTarget(self, action: #selector(addmarks), for: .touchUpInside)
        cell.btnAddMarks.tag = indexPath.row
        cell.txtSyllabuc.text = testListObj.syllabus
        cell.txtSyllabuc.tag = indexPath.row
    cell.lblStatus.text = testListObj.status
        cell.btnEditSyllabus.tag = indexPath.row
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
       if(SharedClass.sharedInstance.teacherSelectedSubject.subjectname == "Class Teacher") {
        cell.btnEditSyllabus.isHidden = true
        if(testListObj.status == "DRAFT") || (testListObj.status == "CLOSED"){
            cell.btnAddMarks.isHidden = true
        }
        else if(testListObj.status == "ACTIVE") || (testListObj.status == "DONE"){
            cell.btnAddMarks.isHidden = false
        }
           
      }else{
        
        if(testListObj.status == "ACTIVE")
        {
           cell.btnAddMarks.isHidden = false
            cell.btnEditSyllabus.isHidden = false
            
        }
        else if(testListObj.status == "DRAFT"){
            cell.btnAddMarks.isHidden = true
            cell.btnEditSyllabus.isHidden = false
            
        }
        else if (testListObj.status == "DONE"){
            cell.btnAddMarks.isHidden = false
            cell.btnEditSyllabus.isHidden = true
        }
        else if (testListObj.status == "CLOSED"){
            cell.btnAddMarks.isHidden = true
            cell.btnEditSyllabus.isHidden = true
        }
       
        }
            cell.btnEditSyllabus.addTarget(self, action: #selector( bodyMethod), for: .touchUpInside)
        }
        else{
            cell.txtSyllabuc.isHidden = false
            cell.btnEditSyllabus.isHidden = true
            cell.txtSyllabuc.text = testListObj.syllabus
            if(testListObj.status == "DRAFT") {
                cell.btnAddMarks.isHidden = true
            }
            else if(testListObj.status == "ACTIVE") || (testListObj.status == "DONE") || (testListObj.status == "CLOSED"){
                cell.btnAddMarks.isHidden = false
            }

        }
                      return cell
    }
  //  var body = [String:Any]()
    func bodyMethod(btn:UIButton) {
        //Prepare body
        if (self.selectedTextField != nil) {
            self.selectedTextField.resignFirstResponder()
        }
        for i in 0..<self.testListArray.count {
            let selectedTestObj = self.testListArray[btn.tag]
            let maxMarksValue = selectedTestObj.maxmarks
            let body =  ["testid":selectedTestObj.testid!,"subjectid":selectedTestObj.subjectid!,"syllabus":selectedTestObj.syllabus ?? " ","maxmarks":maxMarksValue] as [String : Any]
            
          //  self.body = body
            ApiHelper.sharedController().callToSaveSyllabus(body: body,successblock: { (todayResult) in
                let message = todayResult!["message"]
                self.showToast(message:  (message as! String))
                print("syllabus is saved  response \(todayResult!)")
            },FailureBlock: nil, viewController: self)

    }

            }
    func addmarks(btn:UIButton){
        if(SharedClass.sharedInstance.userrole == "TEACHER") && (SharedClass.sharedInstance.teacherSelectedSubject.subjectname != "Class Teacher"){
        let  selectedTestObj = self.testListArray[btn.tag]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testAddViewController = storyboard.instantiateViewController(withIdentifier: "TeacherTestAddMarksViewController") as! TeacherTestAddMarksViewController
        testAddViewController.selectedTestObj = self.testListArray[btn.tag]
        self.navigationController?.pushViewController(testAddViewController, animated: true)
        }
        else{
            let  selectedTestObj = self.testListArray[btn.tag]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let testViewController = storyboard.instantiateViewController(withIdentifier: "TeacherTestViewResultsViewController") as! TeacherTestViewResultsViewController
            testViewController.selectedTestObj = self.testListArray[btn.tag]
            self.navigationController?.pushViewController(testViewController, animated: true)
            
        }
        
    }

}
