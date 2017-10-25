//
//  TeacherProfile.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/1/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TeacherProfileViewController: UIViewController {

    @IBOutlet weak var tName: UILabel!
    @IBOutlet weak var tQualification: UILabel!
    @IBOutlet weak var tMobile: UILabel!
    @IBOutlet weak var tEmail: UILabel!
    @IBOutlet weak var tDob: UILabel!
    @IBOutlet weak var tAddress: UILabel!
   
    @IBOutlet weak var texperience: UILabel!
    @IBOutlet weak var lblMySubjects: UILabel!
    @IBOutlet weak var lblDoJ: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    var teacherprofile:TeacherProfileModel!
  
    override func viewDidLoad() {
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(TeacherProfileViewController.submitTapped))
      //  self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
    
        getTeacherDetails()
    }
    func submitTapped()
    {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = storyboard.instantiateViewController(withIdentifier: "SignInController") as! SignInController
            self.navigationController?.pushViewController(vc1, animated: true)
        //self.navigationController?.popToRootViewController(animated: true)
        }


    //API call to get teacherprofile
    func getTeacherDetails()  {
            ApiHelper.sharedController().CallToGetTeacherProfile(successblock: { (Result) in
            print("Get teacher profile response \(Result!)")
 
            self.teacherprofile = TeacherProfileModel.parseData(dict: Result!)
             self.assignTeacher()
        }, FailureBlock: nil, viewController: self)
    }
    
    
    func assignTeacher() {
        
        tName.text = teacherprofile.teachername
        tQualification.text = teacherprofile.qualification
        tMobile.text = teacherprofile.contactnumber
        tEmail.text = teacherprofile.emailid
        tDob.text = teacherprofile.dateofbirth
        lblMySubjects.text = teacherprofile.subjects
        lblDoJ.text = teacherprofile.dateofjoining
        
        tAddress.text = teacherprofile.address
        tAddress.numberOfLines = 0
        tAddress.lineBreakMode = .byWordWrapping
        tAddress.sizeToFit()
        
        texperience.text = teacherprofile.about
//        texperience.numberOfLines = 0
//        texperience.lineBreakMode = .byWordWrapping
//        texperience.frame.size.width = 300
        //texperience.sizeToFit()
        
    }
    
}


