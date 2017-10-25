//
//  AttendenceViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/2/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class AttendenceViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
var studentArray =  [StudentModel]()
   
    var techerSelectedSubject:TeacherMySubject!

    
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnViewAttendence: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func btnSaveAttendence(_ sender: UIButton) {
        
        //Prepare body 
        var bodyArray = [[String:Any]]()
        for i in 0..<self.studentArray.count {
        let selectedObj = self.studentArray[i]
            
        let aDict =  ["id":SharedClass.sharedInstance.userid,"name":selectedObj.name ?? "","attendancestatus":self.boolToString(value: selectedObj.isPresent),"dateofattendance":date(),"gradeid":techerSelectedSubject.gradeid,"sectionname":techerSelectedSubject.sectionname,"classid":selectedObj.id ?? ""] as [String : Any]
        bodyArray.append(aDict)
        }
        
        ApiHelper.sharedController().callToSaveAttendence(bodyArray: bodyArray,successblock: { (todayResult) in
            print("attendence are saved  response \(todayResult!)")
        },FailureBlock: nil, viewController: self)
    }
    
    
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
        lblClass.text = "class  :"+String(SharedClass.sharedInstance.teacherSelectedSubject .gradenumber)+SharedClass.sharedInstance.teacherSelectedSubject.sectionname
        super.viewDidLoad()
        todayAttendenceOfStudent()
       
    }
    
    
   
    //Api Call for getting students list for attendence
    func todayAttendenceOfStudent()  {
        ApiHelper.sharedController().callToGetAttendence(techerSelectedSubject: SharedClass.sharedInstance.teacherSelectedSubject,successblock: { (Result) in
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
        
        cell.lblStudent.text = studentObj.name
        cell.lblId.text = String(studentObj.id)
        cell.lblId.tintColor = UIColor.red
        
        cell.switchAttendence.tag = indexPath.row
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
  //  func switchValueDidChange(sender:UISwitch!) {
  
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

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
