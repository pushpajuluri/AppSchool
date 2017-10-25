//
//  StudentProfileViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 10/3/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class StudentProfileViewController: UIViewController {

    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var syllabusType: UILabel!
    @IBOutlet weak var studentGrade: UILabel!
    @IBOutlet weak var studentClass: UILabel!
    @IBOutlet weak var studentName: UILabel!
     var childSubArray = [ChildMySubject]()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var studentprofile:ChildMySubject!
    var apiCallGrp = DispatchGroup()
    var apiCallQueue = DispatchQueue(label: "com.StudentManagement.dashboard", qos: .userInitiated, attributes:  .concurrent)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(StudentProfileViewController.submitTapped))
        self.tabBarController?.tabBar.isHidden = true
       initiateAPICalls()
        self.activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
     //   UIApplication.shared.beginIgnoringInteractionEvents()
       
    }
    func submitTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = storyboard.instantiateViewController(withIdentifier: "SignInController") as! SignInController
        self.navigationController?.pushViewController(vc1, animated: true)
        //self.navigationController?.popToRootViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initiateAPICalls() {
        apiCallGrp.enter()
        apiCallQueue.sync {
             getMyChildren()
            
      //      UIApplication.shared.endIgnoringInteractionEvents()
        }
       
    }
    

    func getMyChildren() {
        ApiHelper.sharedController().callToGetMychildren(successblock: { (todayResultMySubjects) in
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            
            for dict in myNewDictArray{
                self.studentprofile = ChildMySubject.parseData(dict: dict)
                self.assignStudent()
                self.activityIndicator.stopAnimating()
            }
           
        },FailureBlock: nil,viewController: self)
    }
    func assignStudent() {
        
        teacherName.text = "Teacher Name :"+studentprofile.teachername
        syllabusType.text = "Syllabus Type :"+studentprofile.syllabustype
        studentGrade.text = "Grade Name :"+studentprofile.gradename
        studentClass.text = "Class :"+String(studentprofile.classid)
        studentName.text = "Student Name :"+studentprofile.name
        
        
    }
    
   
}
