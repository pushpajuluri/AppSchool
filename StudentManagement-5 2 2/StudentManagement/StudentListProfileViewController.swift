//
//  StudentListProfileViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 9/28/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit
enum colorType:String {
    case  red = "a"
    case yellow
    case green
    case cyan
}
class StudentListProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var studentArray =  [StudentModel]()
    var techerSelectedClass:TeacherMySubject!
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     todayAttendenceOfStudent(techerSelectedClassValue:SharedClass.sharedInstance.teacherSelectedSubject)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
        
        
        
        var colorArray = [(UIColor.red, "red"), (UIColor.green, "green"), (UIColor.blue, "blue"), (UIColor.yellow, "yellow"), (UIColor.orange, "orange"), (UIColor.lightGray, "grey")]
        
//        var random = { () -> Int in
//            return Int(arc4random_uniform(UInt32(colorArray.count)))
//        } // makes random number, you can make it more reusable
//
//        var (sourceColor, sourceName) = (colorArray[random()])
    
    
   

    //Api Call for getting students list for attendence
    func todayAttendenceOfStudent(techerSelectedClassValue:TeacherMySubject)  {
        self.studentArray.removeAll()
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
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!  StudentListProfileTableViewCell
        let  studentObj = self.studentArray[indexPath.row]
        let color = ["red","blue","green","yellow"]
        if (color.count) != (indexPath.row){
                      //  cell.viewint.backgroundColor = color[indexPath.row-color.count]
        }else{
           // cell.viewint.backgroundColor =
        }
        if (indexPath.row % 2) != 0{
                       cell.viewint.backgroundColor = UIColor.cyan
                  }else{
                       cell.viewint.backgroundColor = UIColor .lightGray
        
                   }
        cell.lblInitial.text = studentObj.name?.characters.first?.description.capitalized
        cell.lblName.text = studentObj.name?.capitalized
        cell.lblAdmsnNo.text = "Admission Number:"+studentObj.admissionnumber!
        cell.lblClassId.text = "Id: "+String(studentObj.id)
        cell.lblFatherName.text = "Father Name:" + studentObj.fathername!
        return cell
}
   
}

