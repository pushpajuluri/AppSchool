//
//  SendMessagesViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/29/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class SendMessagesViewController: UIViewController, UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate{
    var selectedclasstosendmessage:TeacherMySubject!
    var selectedMembers :NSMutableArray = []
    
    @IBOutlet weak var myTableview: UITableView!
   
    

    @IBOutlet weak var txtMessg: UITextField!
    @IBAction func btnsendMessages(_ sender: UIButton) {
        resignFirstResponder()
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
            let filtersArray = listofcontactsArray.filter() { $0.isSelected == true }
          myTableview.isHidden = true
       var recieverslist = [Int]()
             for selectedmember in filtersArray {
            let selectedObj = selectedmember as! SendMessageModel
            recieverslist.append(selectedObj.parentid)
        }
        
      // recieverslist.append(selectedMembers.value(forKey: "parentid") as! Int)
        let body = ["senderid":SharedClass.sharedInstance.userid,"message":self.txtMessg.text,"recievers":recieverslist,"classroomid":SharedClass.sharedInstance.teacherSelectedSubjectToAddmessage.id] as [String : Any]
 
        
        ApiHelper.sharedController().callToSendNewMessage(bodyArray: body,successblock: { (todayResult) in
            print("messages are saved  response \(todayResult!)")
            let message = todayResult!["message"]
            self.showToast(message:  (message as! String))
        },FailureBlock: nil, viewController: self)
        }
        else
        {
            var recieverslist = [Int]()
            recieverslist.append(SharedClass.sharedInstance.parentSelectedChildToAddmessage.classteacherid)
             let body = ["senderid":SharedClass.sharedInstance.parentSelectedChildToAddmessage.studentid,"message":self.txtMessg.text,"recievers":recieverslist,"classroomid":SharedClass.sharedInstance.parentSelectedChildToAddmessage.classid] as [String : Any]
            
            ApiHelper.sharedController().callToSendNewMessageTeacher(bodyArray: body,successblock: { (todayResult) in
                print("messages are saved  response \(todayResult!)")
                let message = todayResult!["message"]
                self.showToast(message:  (message as! String))
            },FailureBlock: nil, viewController: self)
        
            
        }
    }
    
    @IBOutlet weak var btnsendMessg: UIButton!
    @IBOutlet weak var lblslctstudent: UILabel!
    @IBOutlet weak var selectStudent: UIPickerView!
    var listofcontactsArray = [SendMessageModel]()
    var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
       self.hideKeyboardWhenTappedAround()
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
             getStudentsForMessage()
        }
       // self.selectStudent.reloadAllComponents()
        tapGesture.numberOfTapsRequired = 1
        lblslctstudent.addGestureRecognizer(tapGesture)
       lblslctstudent.isUserInteractionEnabled = true
        tapGesture.addTarget(self, action: #selector( tempMethod))
       // selectStudent.isHidden=true
      lblslctstudent.layer.borderWidth = 3.0;
    }
    func  tempMethod(){
        
        myTableview.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //API call for students
    func getStudentsForMessage()  {
        ApiHelper.sharedController().callToGetComposeMessage(successblock: { (todayResult) in
            
            print("Got student response\(todayResult!)")
            let  myNewDictArray = todayResult as! Array<Dictionary<String,Any>>?
            for dict in myNewDictArray!{
                self.listofcontactsArray.append(SendMessageModel.parseData(dict: dict))
               //   self.selectStudent.reloadAllComponents()
            }
     DispatchQueue.main.async {
                self.myTableview.reloadData()
            }

        }, FailureBlock: nil, viewController: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listofcontactsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!  SendMessageTableViewCell
         let classname = listofcontactsArray[indexPath.row];
        cell.lblName.text = classname.name 
        if(classname.isSelected){
                cell.accessoryType=UITableViewCellAccessoryType.checkmark
        }
        else{
            cell.accessoryType=UITableViewCellAccessoryType.none

        }
               return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tappedItem = listofcontactsArray[indexPath.row] as SendMessageModel
        tappedItem.isSelected = !tappedItem.isSelected
        self.updateCell(indexPath: indexPath)
        /*
        let classname = listofcontactsArray[indexPath.row];
        SharedClass.sharedInstance.teacherSelectedContactToSendMessage = classname
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            tappedItem.isSelected = true
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
                       let tappedItem = listofcontactsArray[indexPath.row];
                tappedItem.isSelected = false
                }
 */
          }
    
    func updateCell(indexPath:IndexPath){
        
        self.myTableview.beginUpdates()
        self.myTableview.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic) //try other animations
        self.myTableview.endUpdates()
    }
 

//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1;
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
//        return listofcontactsArray.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        self.view.endEditing(true)
//        let classname = listofcontactsArray[row];
//        return String(classname.name)
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let classname = listofcontactsArray[row]
//        self.selectStudent.isHidden = true
//      //  self.lblrecipients.text = classname.name
//      // SharedClass.sharedInstance.teacherSelectedContactToSendMessage = classname
//    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      //   self.lblrecipients = textField
    }

}
