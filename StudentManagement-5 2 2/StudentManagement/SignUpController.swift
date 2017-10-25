//
//  SignUpController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 5/24/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class User: NSObject {
    var SchoolName:String = ""
    var SchoolCode:String = ""
    var ContactName:String = ""
    var ContactNumber:String = ""
    var email:String = ""
    var Street:String = ""
    var password:String = ""
    var confirmpassword:String = ""
    var yoe:String = ""
    var city:String = ""
    
}
class SignUpController: UIViewController {
    @IBOutlet var txtSchoolName:UITextField!
    @IBOutlet var txtSchoolCode:UITextField!
    @IBOutlet var txtStreet:UITextField!
    @IBOutlet var txtemail:UITextField!
    @IBOutlet var txtpassword:UITextField!
    @IBOutlet var txtconfirmpassword:UITextField!
    @IBOutlet var txtyoe:UITextField!
    @IBOutlet var txtContactNumber:UITextField!
    @IBOutlet var txtContactName:UITextField!
    @IBOutlet var txtcity:UITextField!
   
    @IBOutlet weak var scrollVi: UIScrollView!


    override func viewDidLoad() {
        self.txtSchoolName.text = "St Joseph"
        self.txtSchoolCode.text = "STJ"
        self.txtContactNumber.text = "8801522135"
        self.txtContactName.text = "RamaKrishna"
        self.txtStreet.text = "Chandramouli nagar"
        self.txtemail.text = "stj@gmail.com"
        self.txtpassword.text = "stj"
        self.txtconfirmpassword.text = "stj"
        self.txtyoe.text = "1975-09-02"
        self.txtcity.text = "Guntur"


        self.scrollVi.contentSize = CGSize(width: self.scrollVi.frame.size.width, height: 1000)
          super.viewDidLoad()
        self.txtContactNumber.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SubmitTapped()
    {
        signUpCall()
        if self.txtSchoolName.text == "" || self.txtSchoolCode.text == "" || self.txtContactNumber.text == "" || self.txtContactName.text == "" || self.txtStreet.text == "" || self.txtemail.text == "" || self.txtpassword.text == "" || self.txtconfirmpassword.text == "" || self.txtyoe.text == "" || self.txtcity.text == "" {
            let alertView = UIAlertView(title: "Message", message: "Please enter all the details", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
            alertView.show()
        }
        else
        {
           let userObj = User()
            userObj.SchoolName = self.txtSchoolName.text!
            userObj.SchoolCode = self.txtSchoolCode.text!
            userObj.ContactNumber = self.txtContactNumber.text!
            userObj.ContactName = self.txtContactName.text!
            userObj.Street = self.txtStreet.text!
            userObj.password = self.txtpassword.text!
            userObj.confirmpassword = self.txtconfirmpassword.text!
            userObj.yoe = self.txtyoe.text!
            userObj.city = self.txtcity.text!
            userObj.email = self.txtemail.text!
            
            if saveUser(userObj: userObj) == true {
                //Sign in
                self.navigateToSignInpage()
            }
            else
            {
                let alertView = UIAlertView(title: "Message", message: "Sign up failure", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
                alertView.show()

            }
        }
 
    }
    
    func signUpCall() {
    let schoolname : String = self.txtSchoolName.text!
    let schoolcode : String = self.txtSchoolCode.text!
    let contactname : String = self.txtContactName.text!
    let contactnumber : String = self.txtContactNumber.text!
    let emailid : String = self.txtemail.text!
    let password:String = self.txtpassword.text!
    let street : String = self.txtStreet.text!
    let city : String = self.txtcity.text!
    let dateofestablishment : String = self.txtyoe.text!
        
        let postString = ["schoolname":schoolname, "schoolcode": schoolcode,"contactname": contactname,"contactnumber": contactnumber,"emailid": emailid,"street": street,"city": city,"dateofestablishment": dateofestablishment,"password": password]
        
        
        
        let url = URL(string: "http://192.168.0.82:8080/register")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application-idValue", forHTTPHeaderField: "secret-key")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        do{
            let data =  try NSURLConnection.sendSynchronousRequest(request,returning:nil)
            let finalresult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("Got response : \(finalresult)")
           // if let dict = finalresult as? [String : Any] {
            //    if let name = dict["schoolname"] as? String {
               //     print("name:\(name)")
              //  }
            // }
        }
        catch  let error {
            print("Error came : \(error.localizedDescription)")
        }
    }
    
    func navigateToSignInpage()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = storyboard.instantiateViewController(withIdentifier: "SignInController") as! SignInController
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    
    
    func saveUser(userObj:User)->Bool
    {
        let docpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let pathStr = docpath!+"/users.plist"
        var usersArray = NSArray(contentsOfFile: pathStr) as? NSMutableArray
        print( usersArray )
        if usersArray == nil
        {
            usersArray = NSMutableArray()
        }
        else
        {
            usersArray = NSMutableArray(array: usersArray!)
        }
        
            let emailsArray = usersArray?.value(forKey: "email") as! NSArray
            if emailsArray.contains(userObj.email)
            {
                //Already there
                return false
            }
            else
            {
                //Add new Object
                let userDict = NSMutableDictionary()
                userDict.setObject(userObj.SchoolName, forKey: "SchoolName" as NSCopying)
                 userDict.setObject(userObj.SchoolCode, forKey: "SchoolCode" as NSCopying)
                 userDict.setObject(userObj.Street, forKey: "Street" as NSCopying)
                userDict.setObject(userObj.ContactNumber, forKey: "ContactNumber" as NSCopying)
                userDict.setObject(userObj.ContactName, forKey: "ContactName" as NSCopying)
                 userDict.setObject(userObj.email, forKey: "email" as NSCopying)
                 userDict.setObject(userObj.yoe, forKey: "yoe" as NSCopying)
                 userDict.setObject(userObj.city, forKey: "city" as NSCopying)
                userDict.setObject(userObj.password, forKey: "password" as NSCopying)
                 userDict.setObject(userObj.confirmpassword, forKey: "confirmpassword" as NSCopying)
             
                
                usersArray?.add(userDict)
                
            }
            //write to File
          
            let fileStatus = usersArray?.write(to: URL(fileURLWithPath:pathStr), atomically: true)
            print("File status is \(fileStatus)")
            return fileStatus!
    }
 
  
    
    @available(iOS 2.0, *)
     public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return true
    }
    
    @available(iOS 2.0, *)
     public func textFieldDidBeginEditing(_ textField: UITextField) // became first responder
    {
    
    }
    
    @available(iOS 2.0, *)
     public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    {
    return true
    }
    
    @available(iOS 2.0, *)
     public func textFieldDidEndEditing(_ textField: UITextField) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    {
    //return true
    }
    
    @available(iOS 10.0, *)
     public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) // if implemented, called in place of textFieldDidEndEditing:
    {
        //return true
    }
    

  /*public  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
        if textField == self.txtmobile
        {
            if (self.txtmobile.text?.characters.count)! > 9
            {
                return false;
            }
        }
        return true
    }*/
    
    func didChangeText(textField:UITextField) {
        
        if textField == self.txtContactNumber
        {
            if (self.txtContactNumber.text?.characters.count)! > 9
            {
            
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

