 //
//  ViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 5/24/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit
import Material

class SignInController: UIViewController {

    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 32
    var loginSubArray = [LoginResponseModel]()
    @IBOutlet var txtUserName:TextField!
    @IBOutlet var txtPwd:TextField!
    var schoolName = ""
    var finalResult = ""
    
    @IBAction func forgot(_ sender: UIButton) {
        presentAlert()
    }

    override func viewDidLoad() {
        if (currentReachabilityStatus == .notReachable){
            let alertView = UIAlertView(title: "Message", message: "connect to network.", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
            alertView.show()
        }
   self.txtUserName.text = "harinath@omniwyse.com"
     self.txtPwd.text = "harinath"
        
        
        self.hideKeyboardWhenTappedAround()
       initializefield()
       prepareResignResponderButton()
       super.viewDidLoad()
    }
    

    
    func initializefield() {
        txtPwd.tintColor = UIColor.white
        txtUserName.tintColor = UIColor.white
        
        //Left Images 
        let leftView = UIImageView()
        leftView.image = #imageLiteral(resourceName: "user Icon")
        txtUserName.leftView = leftView
        view.layout(txtUserName).center(offsetY: -txtPwd.height - 60).left(20).right(20)
        
        let leftView1 = UIImageView()
        leftView1.image = #imageLiteral(resourceName: "password lock")
        txtPwd.leftView = leftView1
        view.layout(txtPwd).center(offsetY: -txtPwd.height ).left(20).right(20)
        
    }
    
    /// Prepares the resign responder button.
    fileprivate func prepareResignResponderButton() {
        let btn = RaisedButton(title: "Login", titleColor: UIColor.white)
        btn.backgroundColor = UIColor.red
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(handleResignResponderButton(button:)), for: .touchUpInside)
        view.layout(btn).width(100).height(constant).top(385).right(160)
    }
    
    /// Handle the resign responder button.
    @objc
    internal func handleResignResponderButton(button: UIButton) {
        txtUserName?.resignFirstResponder()
        txtPwd?.resignFirstResponder()
       //  navigateToNectClassTeacher()
        signInTapped()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentAlert() {
        let alertController = UIAlertController(title: "Email?", message: "Please input your email:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields?[0]
            {
                
            }
            else
            {
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    
    @IBAction func signInTapped()
    {
        ApiHelper.sharedController().emailid = self.txtUserName.text
        ApiHelper.sharedController().password = self.txtPwd.text
          if self.txtUserName.text == ""
        {
            let alertView = UIAlertView(title: "Message", message: "Please enter userName", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
            alertView.show()
        }
          else if self.txtPwd.text == "" {
            let alertView = UIAlertView(title: "Message", message: "Please enter password", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
            alertView.show()
        }
       ApiHelper.sharedController().signInApiCall(successblock: { (finalResult) in
//            
//            
//            let  myNewDictArray = finalResult as? [String:Any]
//            
//            for dict in myNewDictArray!{
//                self.loginSubArray.append(LoginResponseModel.parseData(dict: dict))
//                
//                //todayAttendenceOfStudent()
//            }
//            let loginid = finalResult?["userid"]
//           SharedClass.sharedInstance.userid = loginid as! Int?

            if let dict = finalResult as? [String : Any]
            {
                 let schoolName = (dict["tenantName"] as Any)
                let description = (dict["description"])
                let id = (dict["tenantId"])
                    print("name:\(schoolName)")
                    let loginDetailObj = ResponseSigninModel()
                    loginDetailObj.resSchool = schoolName as? String
                loginDetailObj.resId = id as? Int
                    loginDetailObj.resDescription = description as? String
                let loginid = finalResult!["userId"]
                let userrole = finalResult!["userrole"]
                           SharedClass.sharedInstance.userid = loginid as! Int!
                SharedClass.sharedInstance.userrole = userrole as! String!
                
                    GlobalVariable.sharedController().loginDetails = loginDetailObj

       //  self.navigateToNectClassTeacher()
        self.testClass()
            }
        }, FailureBlock: nil, viewController: self)
        
       //     let alertView = UIAlertView(title: "Message", message: "User does not exists.", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
      //      alertView.show()
        
       //navigateToNextClass()
        
return
        if self.txtUserName.text == "" || self.txtPwd.text == ""
        {
            let alertView = UIAlertView(title: "Message", message: "Please enter userName", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
            alertView.show()
        }
        else{
            if checkuserExists(emailID: self.txtUserName.text!) == true {
                navigateToNextClass()
            }
            else
            {
                let alertView = UIAlertView(title: "Message", message: "User does not exists.", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
                alertView.show()
            }
        }
    }
    
    func testClass(){
        if(SharedClass.sharedInstance.userrole == "TEACHER") {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let dashboardController = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            dashboardController.tabBarItem.title = "Home"
            dashboardController.tabBarItem.image = UIImage(named: "home-7")
            let dashNav = UINavigationController(rootViewController: dashboardController)
            
            let messagesController = storyboard.instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
            messagesController.tabBarItem.title = "Messages"
            messagesController.tabBarItem.image = UIImage(named: "attandance-icon-hover")
            let messagesNav = UINavigationController(rootViewController: messagesController)
            
            let assignmentController = storyboard.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
            assignmentController.tabBarItem.title = "ITeach"
            assignmentController.tabBarItem.image = UIImage(named: "i-schedule")
            let assignmentNav = UINavigationController(rootViewController: assignmentController)
            
            let tabbarController = UITabBarController()
            
        tabbarController.setViewControllers([ dashNav,messagesNav,assignmentNav], animated: true)
            self.present(tabbarController, animated: true, completion: nil)

        }
        
        else if(SharedClass.sharedInstance.userrole == "PARENT"){
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let dashboardController = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            dashboardController.tabBarItem.title = "Home"
            dashboardController.tabBarItem.image = UIImage(named: "home-7")
            let dashNav = UINavigationController(rootViewController: dashboardController)
            
            let messagesController = storyboard.instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
            messagesController.tabBarItem.title = "Messages"
            messagesController.tabBarItem.image = UIImage(named: "attandance-icon-hover")
            let messagesNav = UINavigationController(rootViewController: messagesController)
            
            let assignmentController = storyboard.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
            assignmentController.tabBarItem.title = "Mychild"
            assignmentController.tabBarItem.image = UIImage(named: "i-schedule")
            let assignmentNav = UINavigationController(rootViewController: assignmentController)
            
            let tabbarController = UITabBarController()
            
            tabbarController.setViewControllers([ dashNav,messagesNav,assignmentNav], animated: true)
            self.present(tabbarController, animated: true, completion: nil)
            
        }
    }

    func navigateToNectClassTeacher()
    {
        if(SharedClass.sharedInstance.userrole == "TEACHER") {
            //Tab controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let dashboardController = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            dashboardController.tabBarItem.title = "Home"
            dashboardController.tabBarItem.image = UIImage(named: "home-7")
            
            let dashNav = UINavigationController(rootViewController: dashboardController)
            
            let mysubjectController = storyboard.instantiateViewController(withIdentifier: "MasterViewController") as! MasterViewController
            mysubjectController.tabBarItem.title = "Time Line"
            mysubjectController.tabBarItem.image = UIImage(named: "timeline-icon-normal")
            let mysubNav = UINavigationController(rootViewController: mysubjectController)
            
           
            let attendanceController = storyboard.instantiateViewController(withIdentifier: "StudentMenuViewController") as! StudentMenuViewController
            attendanceController.tabBarItem.title = "Attendance"
            attendanceController.tabBarItem.image = UIImage(named: "attandance-icon-hover")
            let attendanceNav = UINavigationController(rootViewController: attendanceController)
            
            let assignmentController = storyboard.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
            assignmentController.tabBarItem.title = "Tests"
            assignmentController.tabBarItem.image = UIImage(named: "i-schedule")
            let assignmentNav = UINavigationController(rootViewController: assignmentController)
            
            let teacherController = storyboard.instantiateViewController(withIdentifier: "TeacherProfileViewController") as! TeacherProfileViewController
            teacherController.tabBarItem.title = "Teacher Profile"
            teacherController.tabBarItem.image = UIImage(named: "i-schedule")
            let teachNav = UINavigationController(rootViewController: teacherController)
            
            let messagesController = storyboard.instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
            messagesController.tabBarItem.title = "Messages"
            messagesController.tabBarItem.image = UIImage(named: "attandance-icon-hover")
            let messagesNav = UINavigationController(rootViewController: messagesController)
            
            
            let tabbarController = UITabBarController()
            
            tabbarController.setViewControllers([ dashNav,mysubNav,attendanceNav,messagesNav,assignmentNav,teachNav], animated: true)
//            tabbarController.tabBar.isTranslucent = false
//            tabbarController.tabBar.backgroundColor = UIColor.blue
            self.present(tabbarController, animated: true, completion: nil)
                   }
    }

    
    func navigateToNextClass()
    {
        if(true == true) {
            //Tab controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            homeController.tabBarItem.title = "Home"
            homeController.tabBarItem.image = UIImage(named: "home-7")
            let homeNav = UINavigationController(rootViewController: homeController)
            
            let settingsController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            settingsController.tabBarItem.title = "Settings"
            settingsController.tabBarItem.image = UIImage(named: "gear-7")
            let settingsNav = UINavigationController(rootViewController: settingsController)

            
            let tabbarController = UITabBarController()
            tabbarController.setViewControllers([ homeNav,settingsNav], animated: true)
            self.present(tabbarController, animated: true, completion: nil)
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToSignUppage()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
      
        let vc1 = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    
    func checkuserExists(emailID:String)->Bool
    {
        let docpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let pathStr = docpath!+"/users.plist"

        print("my users path is \(pathStr)")
       
        var usersArray = NSArray(contentsOfFile: pathStr) as? NSMutableArray
        if usersArray == nil
        {
            usersArray = NSMutableArray()
            return false
        }
        else
        {
            usersArray = NSMutableArray(array: usersArray!)
        }
        
        let emailsArray = usersArray?.value(forKey: "email") as! NSArray
        
        print(emailsArray,  "List of available emails")
        if emailsArray.contains(emailID)
        {
            //Already there
            print("User exists");
            return true
        }
        else
        {
            print("user does not exists");
            return false
        }
    }

}

