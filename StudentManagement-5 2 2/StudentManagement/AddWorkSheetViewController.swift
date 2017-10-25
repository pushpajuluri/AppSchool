//
//  AddWorkSheetViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/14/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class AddWorkSheetViewController: UIViewController,UIPickerViewDataSource {

    var lessonSubArray = [AddAssignmentModel]()
    var listofworksheetArray = [ListofworksheetslistModel]()
    //var id = 1
    //Date
    func getCurrentMillis()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
   var datepicker : UIDatePicker = UIDatePicker()
    var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()

    @IBOutlet weak var wrkshtPicker: UIPickerView!
    
    @IBOutlet weak var txtTag: UITextField!
    @IBOutlet weak var txtLssn: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtws: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBAction func btnSubmit(_ sender: UIButton) {
        let selectedTimeLine:String
        if(SharedClass.sharedInstance.techerSelectedTimeLine == nil){
            selectedTimeLine = ""
        }
        else{
            selectedTimeLine = SharedClass.sharedInstance.techerSelectedTimeLine.lessonname!
        }

        let body =  ["id":SharedClass.sharedInstance.teacherSelectedSubject.id,"worksheetname":self.txtws.text,"dateofassigned":getCurrentMillis(),"duedate":datePickerChanged(sender: datepicker),"subjectname":SharedClass.sharedInstance.teacherSelectedSubject.subjectname ,"worksheettags":self.txtTag.text,"lessonname":selectedTimeLine] as [String : Any]
        // call to add lesson
        
        ApiHelper.sharedController().callToAddWorkSheet(bodyArray: body,successblock: { (Result) in
            let message = Result!["message"]
            self.showToast(message:  (message as! String))
            print("worksheet are saved  response \(Result!)")
        },FailureBlock: nil, viewController: self)
    }

        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
       getworksheetDetails()
        self.hideKeyboardWhenTappedAround()
        
        wrkshtPicker.reloadAllComponents()
        
        tapGesture.numberOfTapsRequired = 1
        txtws.addGestureRecognizer(tapGesture)
        txtws.isUserInteractionEnabled = true
        tapGesture.addTarget(self, action: #selector( tempMethod))
        wrkshtPicker.isHidden=true
        // Do any additional setup after loading the view.
    }
    func  tempMethod(){
        
        wrkshtPicker.isHidden = false
    }
    
    //API call for getting lessons
    func getMylessons() {
        
        
        let id = 1
        
        var body = ["id":id,"subjectname":SharedClass.sharedInstance.teacherSelectedSubject.subjectname] as [String : Any]
        
        
        ApiHelper.sharedController().callToGetLessonsList(bodyArray: body,successblock: { (Result) in
            print("got the lesson response \(Result!)")
            
            let  myNewDictArray = Result as? Array<Dictionary<String, Any>>
            
            for dict in myNewDictArray!{
                self.lessonSubArray.append(AddAssignmentModel.parseData(dict: dict))
                
            }
            
        },FailureBlock: nil, viewController: self)
    }

    //API call to get teacherworksheet
    func getworksheetDetails()  {
        ApiHelper.sharedController().CallToGetWorksheetList(successblock: { (Result) in
            print("Get worksheetlist\(Result!)")
            let  myNewDictArray = Result
            for dict in myNewDictArray!{
                self.listofworksheetArray.append(ListofworksheetslistModel.parseData(dict: dict))
                //todayAttendenceOfStudent()
            }
            self.wrkshtPicker.reloadAllComponents()
        }, FailureBlock: nil, viewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(listofworksheetArray.count == 0)
        {
            return 0
        }
        else
        {
        return listofworksheetArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        
        let classname = listofworksheetArray[row];
        //    let selected = String(classname.gradeid)+classname.sectionname
        return classname.worksheetname
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(listofworksheetArray.count > 0)
        {
        self.wrkshtPicker.isHidden = true
        let classname = listofworksheetArray[row];
       self.txtws.text =  classname.worksheetname
        
    }
    
    }
    func textFieldDidChange(_ textField:UITextField) {
        wrkshtPicker.isHidden = false
        
    }

    
    //date picker
    func closeKeyBoard() {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing( _ textField: UITextField) {
        let datepicker = UIDatePicker()
        if textField == self.txtws{
            wrkshtPicker.isHidden = false
            txtws.resignFirstResponder()
        }
      txtDate.inputView = datepicker
        datepicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
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
