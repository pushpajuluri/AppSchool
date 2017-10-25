//
//  ApiHelper.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 7/20/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class ApiHelper: NSObject {
    static var apiHelper = ApiHelper()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var  loginDetails:ResponseSigninModel?
 //   var teacherschedule:TeacherScheduleTodayModels?
    class func sharedController()->ApiHelper {
        return self.apiHelper
    }
    
    
    var emailid:String?
    var password:String?
  //  var id = 1
    var  gradeId:String?
    //var sectionname = "A"
    var studentObj:StudentModel!
    var tenantname = "dps"
    var tenantid = 2
    
       //call for signin
    func signInApiCall(successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
     //   let emailid : String = self.txtUserName.text!
       // let password : String = self.txtPwd.text!
    let postString = ["emailid":ApiHelper.sharedController().emailid, "password": ApiHelper.sharedController().password ]
        
        let loginString = NSString(format: "%@:%@", emailid!, password!)
        let loginData: NSData = loginString.data(using: String.Encoding.utf8.rawValue)! as NSData
        let base64LoginString = loginData.base64EncodedString(options: NSData.Base64EncodingOptions())
        var  authString = String(format:"Basic %@", base64LoginString)
           SharedClass.sharedInstance.apihelper = authString

        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/userlogin")
        var request = URLRequest(url: (url)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
         request.setValue(authString, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let finalResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of school details: \(finalResult)")
                DispatchQueue.main.async {
                    successblock(finalResult as AnyObject?)
                }
            }
            catch {
            }
        }
    }

    //call to get todayschedule
func callToGetToday(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
    let postString = ["id":SharedClass.sharedInstance.userid]
    let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/teacherschedule/today")
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue(tenantname, forHTTPHeaderField: "tenant")
    request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
    request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
    NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
        
        if let errorObj = error {
            print("Got an error \(errorObj)")
            if let failureBlock = failureblock {
                failureBlock(errorObj as NSError?)
            }
            return
        }
        do {
            let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print("Got response of Today: \(todayResult)")
            DispatchQueue.main.async {
                successblock(todayResult as! Array<Dictionary<String,Any>>)
            }
        }
        catch {
        }
    }
    }
    
    //call to get tommorowschedule
    func callToGetTommorow(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":SharedClass.sharedInstance.userid]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/teacherschedule/tomorrow")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of Tommorow: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }
    
    //call to get subjects
        func callToGetMysubjects(successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
            let postString = ["id":SharedClass.sharedInstance.userid]
            let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/mysubjects")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(tenantname, forHTTPHeaderField: "tenant")
            request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
            request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
                
                if let errorObj = error {
                    print("Got an error \(errorObj)")
                    if let failureBlock = failureblock {
                        failureBlock(errorObj as NSError?)
                    }
                    return
                }
                do {
                    let todayResultMySubjects = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print("Got response of my subjects: \(todayResultMySubjects)")
                    DispatchQueue.main.async {
                        successblock(todayResultMySubjects as AnyObject?)
                    }
                }
                catch {
                }
                
            }


}
    
    
    //call to get children for parent app
    func callToGetMychildren(successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":SharedClass.sharedInstance.userid]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/parentchildrens")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResultMySubjects = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of my children: \(todayResultMySubjects)")
                DispatchQueue.main.async {
                    successblock(todayResultMySubjects as AnyObject?)
                }
            }
            catch {
            }
            
        }
        
        
    }

    //call to get birthdays
    func callToGetMybirthday(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["teacherid":SharedClass.sharedInstance.userid] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/today/classsubjectteacher")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayBirthday = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of todays birthday : \(todayBirthday)")
                DispatchQueue.main.async {
                    successblock(todayBirthday as? Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
            
        }
        
        
    }
    //call to get tomorow birthday
    func callToGetMybirthdayTommorrow(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["teacherid":SharedClass.sharedInstance.userid] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)//tomorrow/classsubjectteacher")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let tommorowBirthday = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of tommorow birthday : \(tommorowBirthday)")
                DispatchQueue.main.async {
                    successblock(tommorowBirthday as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
            
        }
 //
    }
    
    //call to get today news
    func callToGetNews(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":SharedClass.sharedInstance.userid]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/news")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of news: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }
    
    //call to get today notification
    func callToGetNotification(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":SharedClass.sharedInstance.userid]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/parentnotifications")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of notification \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }

    
    //call to get today holidays
    func callToGetHoliday(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":SharedClass.sharedInstance.userid]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/holidays")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of holidays: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }
    
    //call to get today events
    func callToGetEvents(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":SharedClass.sharedInstance.userid]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/events")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of events: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }



    //CallToGetTeacherProfile
   
    func CallToGetTeacherProfile(successblock : @escaping (Dictionary<String,Any>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":SharedClass.sharedInstance.userid] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/teacherprofile")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of teacher profile : \(Result)")
                DispatchQueue.main.async {
                    successblock(Result as! Dictionary<String,Any>)
                }
            }
            catch {
            }
            
        }
        //
    }
    
    //call to get subjects
    func callToGetMysubjectsForClass(successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":SharedClass.sharedInstance.userid]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/myclassroom")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResultMySubjects = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of my class subjects: \(todayResultMySubjects)")
                DispatchQueue.main.async {
                    successblock(todayResultMySubjects as AnyObject?)
                }
            }
            catch {
            }
            
        }
        
        
    }

    
    //call to get attendence
    func callToGetAttendence(techerSelectedSubject:TeacherMySubject,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["gradeid":techerSelectedSubject.gradeid,"sectionname":techerSelectedSubject.sectionname] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/listofstudentsofclassroom")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of todays birthday : \(Result)")
             
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
            }
            catch {
            }
            
        }
        
    }
    
    //call to save attendence
    func callToSaveAttendence(bodyArray:Array<Dictionary<String,Any>>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/recordattendance")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyArray, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of to save attendence : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
                
            }
            catch {
            }
            
        }
        
        
    }
    //call to save marks in test
    
    func callToSaveMarks(bodyArray:Array<Dictionary<String,Any>>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/addmarks")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyArray, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of to saving marks : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
               
            }
            catch {
            }
            
        }
       
    }

    
    
    //call to save syllabus in tests
    func callToSaveSyllabus(body:Dictionary<String,Any>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/addoreditsyllabus")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: body, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of to save syllabus in tests : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
            }
            catch {
            }
            
        }
       
    }
    //call to enter marks
    func callToEnterMarks(selectedTestObj: TestListModel,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
//        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubjectToAddmarks.id,"testtype":selectedTestObj.testtype,"subjectname":SharedClass.sharedInstance.teacherSelectedSubjectToAddmarks.subjectname] as [String : Any]
        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubject.id,"testtype":selectedTestObj.testtype,"subjectname":SharedClass.sharedInstance.teacherSelectedSubject.subjectname] as [String : Any]

        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/entermarks")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of enter marks : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
            }
            catch {
            }
            
        }
        
    }

    //call to view result for class
    func callToViewMarks(selectedTestObj: TestListModel,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        //        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubjectToAddmarks.id,"testtype":selectedTestObj.testtype,"subjectname":SharedClass.sharedInstance.teacherSelectedSubjectToAddmarks.subjectname] as [String : Any]
        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubject.id,"testtype":selectedTestObj.testtype!] as [String : Any]
        
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/viewresults")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of view marks : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
            }
            catch {
            }
            
        }
        
    }

    //call to view result for child
    func callToViewMarksChild(selectedTestObj: TestListModel,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        //        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubjectToAddmarks.id,"testtype":selectedTestObj.testtype,"subjectname":SharedClass.sharedInstance.teacherSelectedSubjectToAddmarks.subjectname] as [String : Any]
        let postString = ["studentid":SharedClass.sharedInstance.parentSelectedChild.id,"classid":SharedClass.sharedInstance.parentSelectedChild.classid,"gradeid":SharedClass.sharedInstance.parentSelectedChild.gradeid,"id":selectedTestObj.id] as [String : Any]
       
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/marks")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of view marks : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
            }
            catch {
            }
            
        }
        
    }

    
    // call to get timeline in my subjects
    
    func callToGetTimeLineOfMysubject(techerSelectedSubject:TeacherMySubject,successblock :@escaping (AnyObject?) -> Void ,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubject.id,"subjectname":techerSelectedSubject.subjectname] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/timeline")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of Timeline: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult  as AnyObject?)
                }
            }
            catch {
            }
        }
    }
    
    // call to get timeline in my class
    
    func callToGetTimeLineClass(techerSelectedSubject:TeacherMySubject,successblock :@escaping (AnyObject?) -> Void ,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubject.id] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/timeline")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of Timeline: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult  as AnyObject?)
                }
            }
            catch {
            }
        }
    }


    
    // call to get timeline in my child
    
    func callToGetTimeLineChild(parentSelectedClass:ChildMySubject,successblock :@escaping (AnyObject?) -> Void ,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":SharedClass.sharedInstance.parentSelectedChild.classid] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/timeline")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of Timeline: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult  as AnyObject?)
                }
            }
            catch {
            }
        }
    }
    
    // call to get attendance in my child
    
    func callToGetAttendanceChild(parentSelectedClass:ChildMySubject,successblock :@escaping (AnyObject?) -> Void ,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["classid":SharedClass.sharedInstance.parentSelectedChild.classid,"studentid":SharedClass.sharedInstance.parentSelectedChild.studentid] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/studentattendance")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of attendance: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult  as AnyObject?)
                }
            }
            catch {
            }
        }
    }



    //call to Add lesson
    func callToAddLesson(bodyArray:Dictionary<String,Any>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/addlesson")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyArray, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of to adding lesson : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
                
            }
            catch {
            }
            
        }
        
        
    }
    
    
    
    
    
    //CallToGetAssignments
    func CallToGetAssignments(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
       
        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubject.id,"subjectname":SharedClass.sharedInstance.teacherSelectedSubject.subjectname] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/assignedassignmentslist")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of assigned assignment: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }
    
    //CallToGetAssignments for class
    func CallToGetAssignmentsClass(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        
        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubject.id] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/assignedassignmentslist")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of assigned assignment for class: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }

    //CallToGetAssignments for child
    func CallToGetAssignmentsChild(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        
        let postString = ["id":SharedClass.sharedInstance.parentSelectedChild.classid] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/assignments")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of assigned assignment for child: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }

    //CallToGetworksheet
    func CallToGetWorksheet(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
       
        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubject.id,"subjectname":SharedClass.sharedInstance.teacherSelectedSubject.subjectname] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/assignedworksheetslist")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of worksheet\(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }

    //CallToGetworksheet for class
    func CallToGetWorksheetClass(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        
        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubject.id] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/assignedworksheetslist")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of worksheet\(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }
    
    
    //CallToGetworksheet for child
    func CallToGetWorksheetChild(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        
        let postString = ["id":SharedClass.sharedInstance.parentSelectedChild.classid] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/worksheets")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of worksheet for child\(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }


    //CallToGetworksheetList
    func CallToGetWorksheetList(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        print( (SharedClass.sharedInstance.teacherSelectedSubject.id))
        let postString = ["id":SharedClass.sharedInstance.teacherSelectedSubject.id,"subjectname":SharedClass.sharedInstance.teacherSelectedSubject.subjectname] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/teacherschedule/listofworksheets")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of worksheetlist\(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }

    
    
    
    //call to get lesson list
    func callToGetLessonsList(bodyArray:Dictionary<String,Any>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/lessonslist")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyArray, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of to adding lesson : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                }
            catch {
            }
            }
        }
    
    //call to Add assignment
    func callToAddAssignment(bodyArray:Dictionary<String,Any>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/assignassignment")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyArray, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of to adding assignment : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                }
            catch {
            }
            }
        }
    
    //call to Add worksheet
    func callToAddWorkSheet(bodyArray:Dictionary<String,Any>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/assignworksheet")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyArray, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of to adding worksheet : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
            }
            catch {
            }
        }
    }
    
    //call to publish
    func callToPublish(bodyArray:Dictionary<String,Any>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/publishnotification")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyArray, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of publishing : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
                
            }
            catch {
            }
            
        }
        
        
    }


    //call to get test list
    func callToGetTestList(techerSelectedSubject:TeacherMySubject,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
       // let postString = ["id":techerSelectedSubject.id,"subjectname":techerSelectedSubject.subjectname] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/subjectstests/\(techerSelectedSubject.id)/\(techerSelectedSubject.subjectname)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
      //   request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of test list : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
            }
            catch {
            }
            
        }
        
    }
    //call to get test list for class
    func callToGetTestListForClass(techerSelectedSubject:TeacherMySubject,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
         let postString = ["id":techerSelectedSubject.gradeid,"academicyear":1] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/listtests")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
          request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of test list : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
            }
            catch {
            }
            
        }
        
    }

    //call to get test list for child
    func callToGetTestListForChild(parentSelectedClass:ChildMySubject,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["id":parentSelectedClass.gradeid] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/listtestsbystudent")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of test listof child: \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
            }
            catch {
            }
            
        }
        
    }

    
    
    //call to get sent messages
    func callToSentMessages(techerSelectedSubject:TeacherMySubject,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
         let postString = ["senderid":SharedClass.sharedInstance.userid,"classroomid":techerSelectedSubject.id] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/teachermessages")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
           request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of message sent: \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
            }
            catch {
            }
            
        }
        
    }

    //call to get sent messages for child
    func callToSentMessagesChild(parentSelectedChild:ChildMySubject,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let postString = ["senderid":parentSelectedChild.studentid,"classroomid":parentSelectedChild.classid] as [String : Any]
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/parentmessages")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of message sent for parent: \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
            }
            catch {
            }
            
        }
        
    }

    
    //call to send messages
    
    func callToGetComposeMessage(successblock : @escaping (Array<Dictionary<String,Any>>?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/\(SharedClass.sharedInstance.teacherSelectedSubjectToAddmessage.id)/classroomstudents")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
       // request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let todayResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of students to send message: \(todayResult)")
                DispatchQueue.main.async {
                    successblock(todayResult as! Array<Dictionary<String,Any>>)
                }
            }
            catch {
            }
        }
    }
    
//call to send new message
    
    func callToSendNewMessage(bodyArray:Dictionary<String,Any>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/sendmessagetoparent")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyArray, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of to sending message : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
                
            }
            catch {
            }
            
        }
        
        
    }
    
    //call to send new message to techer
    
    func callToSendNewMessageTeacher(bodyArray:Dictionary<String,Any>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/sendmessagetoteacher")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyArray, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of to sending message : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
                
            }
            catch {
            }
            
        }
        
        
    }


    //call to send reply message
    
    func callToSendReplyMessage(bodyArray:Dictionary<String,Any>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController?){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/sendmessagetoparent")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyArray, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of to sending reply message : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
                
            }
            catch {
            }
            
        }
        
        
    }

    //call to send reply message in parent app
    
    func callToSendReplyMessageparent(bodyArray:Dictionary<String,Any>,successblock : @escaping (AnyObject?) -> Void,FailureBlock failureblock : ((NSError?) -> Void)?,viewController:UIViewController?){
        let url = URL(string: "\(Constants.APP_URL)/\(tenantid)/sendmessagetoteacher")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tenantname, forHTTPHeaderField: "tenant")
        request.setValue(SharedClass.sharedInstance.apihelper as! String?, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyArray, options:.prettyPrinted)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
            
            if let errorObj = error {
                print("Got an error \(errorObj)")
                if let failureBlock = failureblock {
                    failureBlock(errorObj as NSError?)
                }
                return
            }
            do {
                let Result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("Got response of to sending reply message : \(Result)")
                
                DispatchQueue.main.async {
                    successblock(Result as AnyObject?)
                }
                
                
            }
            catch {
            }
            
        }
        
        
    }

    
    
    /*
func apiForBodyStringAndBlock(URL aUrl : String, APIName apiName : String, MethodType methodType : String, ContentType contentType : String, BodyString bodyString : String, successblock : @escaping (AnyObject?) -> Void?, failureblock : @escaping (NSError?) -> Void?)
{
    let URLStr : NSURL = NSURL(string: "\(Constants.APP_URL)\(aUrl)")!
    return callServiceWithBlock(successblock: successblock, failureblock: failureblock, APIName: apiName, MethodType: methodType, URL: URLStr as URL, Bodydata: nil, BodyString: bodyString, ContentType: contentType)
}

func apiForBodyDataAndBlock(URL aUrl : String, APIName apiName : String, MethodType methodType : String, ContentType contentType : String, BodyData bodyData : Dictionary<String,Any?>, successblock : @escaping (AnyObject?) -> Void?, failureblock : @escaping (NSError?) -> Void?)
{
    let URLStr : NSURL = NSURL(string: "\(Constants.APP_URL)\(aUrl)")!
    var reqData: NSData?
    do {
        reqData = try JSONSerialization.data(withJSONObject: bodyData, options: .prettyPrinted) as NSData?
    } catch {
        
    }
    return callServiceWithBlock(successblock: successblock, failureblock: failureblock, APIName: apiName, MethodType: methodType, URL: URLStr as URL, Bodydata: reqData, BodyString: nil, ContentType: contentType)
}

//Service method by Radha
func callServiceWithBlock(successblock: @escaping (AnyObject?) -> Void?, failureblock: @escaping (NSError?) -> Void?, APIName api: String?, MethodType methodType: String?, URL aUrl:URL, Bodydata bodyData: NSData?, BodyString bodyStr:String? ,ContentType contentType: String?) -> Void
{
    do
    {
        let request:NSMutableURLRequest =  NSMutableURLRequest(url: aUrl as URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: Constants.TIME_OUT)
        
        if let methodType = methodType  {
            request.httpMethod = methodType
        } else {
            request.httpMethod = Constants.POST
        }
        
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        if let bodyData = bodyData  {
            request.httpBody = bodyData as Data
        }
        else if let bodyStr = bodyStr
        {
            let bodyStr = bodyStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            request.httpBody = bodyStr!.data(using: String.Encoding.utf8)
            print("BODY STRING IS : \n \(bodyStr)")
        }
        
        
        print("WEB SERVICE URL is :\n \(aUrl)")
        
        let config = URLSessionConfiguration.default // Session Configuration
        config.timeoutIntervalForRequest = Constants.TIME_OUT
        config.timeoutIntervalForResource = Constants.TIME_OUT
        let session = URLSession(configuration: config)
        
        // Load configuration into Session
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, connectionError) in
            
            //Got Response
            if connectionError == nil && response != nil, let responceData = data {
                var responseobj:Any?
                do
                {
                    responseobj = try  JSONSerialization.jsonObject(with: responceData, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch _ {
                    print("Error while parsing the API so returning")
                    failureblock(NSError(domain:"JSON Error" ,code : 1000 , userInfo: nil))
                    return
                }
                if  responseobj == nil
                {
                    responseobj = data as AnyObject?
                }
                print("API(\(aUrl)) Response is \(responseobj)")
                successblock(responseobj as! NSDictionary)
            }
            else
            {
                //Error
                if connectionError != nil
                {
                    print("Service Error and Error info is : \(connectionError!.localizedDescription) \n")
                }
                failureblock(connectionError as NSError?)
            }
        })
        dataTask.resume()
    }
    catch _ {
        failureblock(NSError(domain:"Error" ,code : 1000 , userInfo: nil))
    }
}
 
 */

//Validate email
func validateEmailWithString(email: String) -> Bool {
    let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    print(email)
    return emailTest.evaluate(with: email)
    
}
    
}
