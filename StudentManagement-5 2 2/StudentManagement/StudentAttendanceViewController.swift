//
//  StudentAttendanceViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 10/4/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class StudentAttendanceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    var studentattendanceArray =  [studentAttendanceModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
callToGetAttendanceOfMychild(parentSelectedClass:SharedClass.sharedInstance.parentSelectedChild)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func callToGetAttendanceOfMychild(parentSelectedClass:ChildMySubject) {
        SharedClass.sharedInstance.parentSelectedChild=parentSelectedClass
       
        ApiHelper.sharedController().callToGetAttendanceChild(parentSelectedClass:parentSelectedClass,successblock: { (todayResult) in
            print("Get attendance response of child\(todayResult!)")
            
            let  myNewDictArray = todayResult as! Array<Dictionary<String, Any>>
//            
            for dict in myNewDictArray{
               self.studentattendanceArray.append(studentAttendanceModel.parseData(dict: dict))
            }
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        },FailureBlock: nil, viewController: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return studentattendanceArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!  StudentAttendanceTableViewCell
        let  studentObj = self.studentattendanceArray[indexPath.row]
        if studentObj.attendancestatus == 1{
            cell.lblAttendanceStatus.text =  "PRESENT"
        }else{
              cell.lblAttendanceStatus.text =  "ABSENT"
            cell.lblAttendanceStatus.textColor = UIColor.red
        }
     cell.lblDateOfAttendance.text = studentObj.dateofattendance
        return cell
    }
}
