//
//  testViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 7/19/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var teacherSubArray = [TeacherMySubject]()
    var childSubArray = [ChildMySubject]()
    var defaultArray = [Any]()
    
    @IBOutlet weak var schoolName: UITextField!
    
    //Queues
    var apiCallGrp = DispatchGroup()
    var apiCallQueue = DispatchQueue(label: "com.StudentManagement.subjects", qos: .userInitiated, attributes:  .concurrent)
//    override func viewWillAppear(_ animated: Bool) {
//        if(SharedClass.sharedInstance.userrole == "TEACHER")
//        {
//            initiateAPICalls()
//            defaultArray = teacherSubArray
//        }
//        else if(SharedClass.sharedInstance.userrole == "PARENT")
//        {
//            apiCallQueue.sync {
//                getMyChildren()
//            }
//            apiCallQueue.sync {
//                defaultArray = childSubArray
//            }
//            
//        }
//    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
            initiateAPICalls()
            defaultArray = teacherSubArray
        }
        else if(SharedClass.sharedInstance.userrole == "PARENT")
        {
            apiCallQueue.sync {
               getMyChildren()
            }
            apiCallQueue.sync {
               defaultArray = childSubArray
            }
            
        }
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initiateAPICalls() {
        apiCallGrp.enter()
        apiCallQueue.async {
            self.getMysubjectsForclass()
        }
        
        apiCallGrp.enter()
        apiCallQueue.async {
            self.getMysubjects()
        }
        
        apiCallGrp.notify(queue: DispatchQueue.main) {
            self.myTableView.reloadData()
            print("ALL apis for subjects are completed")
            
            
        }
       
    }
    

    func getMysubjects() {
        ApiHelper.sharedController().callToGetMysubjects(successblock: { (todayResultMySubjects) in
            
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            
            for dict in myNewDictArray{
                self.teacherSubArray.append(TeacherMySubject.parseData(dict: dict))
                
            }
            self.defaultArray = self.teacherSubArray
             self.myTableView.reloadData()
            self.apiCallGrp.leave()
        },FailureBlock: nil,viewController: self)
    }
    
    
    func getMysubjectsForclass() {
        ApiHelper.sharedController().callToGetMysubjectsForClass(successblock: { (todayResultMySubjects) in
        
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            for dict in myNewDictArray{
                self.teacherSubArray.append(TeacherMySubject.parseData(dict: dict))
                
            }
            self.defaultArray = self.teacherSubArray
                self.myTableView.reloadData()
            self.apiCallGrp.leave()
            
    },FailureBlock: nil,viewController: self)
    }
    
    
    func getMyChildren() {
        ApiHelper.sharedController().callToGetMychildren(successblock: { (todayResultMySubjects) in
           let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
           
            for dict in myNewDictArray{
                self.childSubArray.append(ChildMySubject.parseData(dict: dict))
            }
            self.defaultArray = self.childSubArray
           self.myTableView.reloadData()
       },FailureBlock: nil,viewController: self)
    }

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TestTableViewCell
        if(SharedClass.sharedInstance.userrole == "TEACHER"){
        let timeLineObj = self.teacherSubArray[indexPath.row]
        cell.lblClss.text = "Class"  + String(timeLineObj.gradenumber)+timeLineObj.sectionname
        cell.lblSub.text = timeLineObj.subjectname
        cell.img.image = UIImage(named:"Teacher Icon.png")
        }else {
            let timeLineObj = self.childSubArray[indexPath.row]
            cell.lblClss.text = timeLineObj.name
            cell.lblSub.text = timeLineObj.sectionname + String(timeLineObj.gradeid)
            cell.img.image = UIImage(named:"Teacher Icon.png")
        }
      return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
     if(SharedClass.sharedInstance.userrole == "TEACHER")
     {
        let  studentMenuObj = self.teacherSubArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mysubjectsViewController = storyboard.instantiateViewController(withIdentifier: "MySubjectsViewController") as! MySubjectsViewController
        mysubjectsViewController.techerSelectedSubject = studentMenuObj
        SharedClass.sharedInstance.teacherSelectedSubject = studentMenuObj
        self.navigationController?.pushViewController(mysubjectsViewController, animated: true)
        }
     else{
        let  studentMenuObj = self.childSubArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mysubjectsViewController = storyboard.instantiateViewController(withIdentifier: "MySubjectsViewController") as! MySubjectsViewController
          mysubjectsViewController.parentSelectedChild = studentMenuObj
        SharedClass.sharedInstance.parentSelectedChild = studentMenuObj
        self.navigationController?.pushViewController(mysubjectsViewController, animated: true)
        }
   }
}
