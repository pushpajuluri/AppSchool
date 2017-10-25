//
//  MessagesViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/19/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var Classpicker: UIPickerView!
    @IBOutlet weak var mytableView: UITableView!
    var messageCell: ReplyMessageTableViewCell!
     var sectionMessages:MessagesModel!
    
    @IBAction func sendMsg(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = storyboard.instantiateViewController(withIdentifier: "SendMessagesViewController") as! SendMessagesViewController
        self.navigationController?.pushViewController(vc1, animated: true)
        

    }
   var messListArray =  [MessagesModel]()
  //  var id = 1
     var techerSelectedClass:TeacherMySubject!
    var parentSelectedClass:ChildMySubject!
    var messesObj:MessagesModel!
    var teacherSubArray = [TeacherMySubject]()
    var childSubArray = [ChildMySubject]()
    var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
     let headerHeight:Double = 50.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
//        if(SharedClass.sharedInstance.userrole == "TEACHER")
//        {
//            getMysubjects()
//        }
//        else{
//            getMychildren()
//        }
       
       // SentMessages(techerSelectedClassValue: teacherSubArray[0])
        DispatchQueue.main.async {
      self.Classpicker.reloadAllComponents()
        }
        
        
        tapGesture.numberOfTapsRequired = 1
        lblClass.addGestureRecognizer(tapGesture)
        lblClass.isUserInteractionEnabled = true
        tapGesture.addTarget(self, action: #selector( tempMethod))
        
        Classpicker.isHidden=true
//        mytableView.sectionHeaderHeight = UITableViewAutomaticDimension
//      mytableView.estimatedSectionHeaderHeight = 60
        // Do any additional setup after loading the view.
    }
    func  tempMethod(){
        
        Classpicker.isHidden = false
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
            getMysubjects()
            getMysubjectsForclass()
        }
        else{
            getMychildren()
        }

    }
    

    //API call for getting subjects
    func getMysubjects() {
        ApiHelper.sharedController().callToGetMysubjects(successblock: { (todayResultMySubjects) in
            print("success")
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            for dict in myNewDictArray{
                self.teacherSubArray.append(TeacherMySubject.parseData(dict: dict))
                
            }
        if(self.teacherSubArray.count>0){
                self.SentMessages(techerSelectedClassValue: self.teacherSubArray.first!);
                self.Classpicker.reloadAllComponents()
                SharedClass.sharedInstance.teacherSelectedSubjectToAddmessage = self.teacherSubArray[0]
            }
        },FailureBlock: nil,viewController: self)
    }
    
    
    func getMysubjectsForclass() {
        ApiHelper.sharedController().callToGetMysubjectsForClass(successblock: { (todayResultMySubjects) in
            
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            self.teacherSubArray.removeAll()
            for dict in myNewDictArray{
                self.teacherSubArray.append(TeacherMySubject.parseData(dict: dict))
          }
            self.Classpicker.reloadAllComponents()
    },FailureBlock: nil,viewController: self)
    }

    
    //API call for getting children
    func getMychildren() {
        ApiHelper.sharedController().callToGetMychildren(successblock: { (todayResultMySubjects) in
            print("success")
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            for dict in myNewDictArray{
                self.childSubArray.append(ChildMySubject.parseData(dict: dict))
            }
            
            if(self.childSubArray.count>0){
                self.SentMessagesParent(ParentSelectedClassValue:self.childSubArray.first!)
                self.Classpicker.reloadAllComponents()
                SharedClass.sharedInstance.parentSelectedChildToAddmessage = self.childSubArray[0]
            }
        },FailureBlock: nil,viewController: self)
    }
 
    //Api Call for getting sent messahes
    func SentMessages(techerSelectedClassValue:TeacherMySubject)  {
        
        self.techerSelectedClass = techerSelectedClassValue
        self.lblClass.text = String(self.techerSelectedClass.gradenumber)+self.techerSelectedClass.sectionname;
        
        self.messListArray.removeAll()
        ApiHelper.sharedController().callToSentMessages(techerSelectedSubject: self.techerSelectedClass,successblock: { (Result) in
            print("Get sent messages response \(Result)")
            if (Result == nil){
                
            }
           // let status = Result!["status"] as! Int
        //  else  if ( Result!["status"] as! Int == 500){
                
        //    }
            else{
            let  myNewDictArray = Result as! Array<Dictionary<String, Any>>
            for dict in myNewDictArray{
                self.messListArray.append(MessagesModel.parseData(dict: dict))
            }
            
            DispatchQueue.main.async {
                self.mytableView.reloadData()
            }
            }
        }, FailureBlock: nil, viewController: self)
    }
   
    //Api Call for getting sent messahes for parent
    func SentMessagesParent(ParentSelectedClassValue:ChildMySubject)  {
        self.parentSelectedClass = ParentSelectedClassValue
        self.lblClass.text = parentSelectedClass.name
        self.messListArray.removeAll()
        ApiHelper.sharedController().callToSentMessagesChild(parentSelectedChild: self.parentSelectedClass,successblock: { (Result) in
            print("Get sent messages response \(Result)")
            if (Result == nil){
                
            }
                // let status = Result!["status"] as! Int
                //  else  if ( Result!["status"] as! Int == 500){
                
                //    }
            else{
                
                let  myNewDictArray = Result as! Array<Dictionary<String, Any>>
                self.messListArray.removeAll()
                for dict in myNewDictArray{
                    self.messListArray.append(MessagesModel.parseData(dict: dict))
                }
                
                DispatchQueue.main.async {
                   self.mytableView.reloadData()
                }
            }
        }, FailureBlock: nil, viewController: self)
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if(SharedClass.sharedInstance.userrole == "TEACHER"){
            return teacherSubArray.count
        }else{
            return childSubArray.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
            let classname = teacherSubArray[row];
            return String(classname.gradenumber)+classname.sectionname+classname.subjectname
        }
        else{
            let classname = childSubArray[row]
            return  classname.name
        }
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
            let classname = teacherSubArray[row]
            self.Classpicker.isHidden = true
            SentMessages(techerSelectedClassValue: teacherSubArray[row])
            SharedClass.sharedInstance.k = row
            SharedClass.sharedInstance.teacherSelectedSubjectToAddmessage = classname
        }else{
            let classname = childSubArray[row]
            self.Classpicker.isHidden = true
            SentMessagesParent(ParentSelectedClassValue:childSubArray[row])
            SharedClass.sharedInstance.parentSelectedChildToAddmessage = classname
        }
       
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//        if textField == self.textbox {
//            self.Classpicker.isHidden = false
//            textField.endEditing(true)
//        }
}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messListArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionMessages:MessagesModel = messListArray[section];
        return sectionMessages.replymessagesArray.count+1;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sectionMessages = messListArray[indexPath.section];
        if(indexPath.row<sectionMessages.replymessagesArray.count){
            return 80.0
       }
        else{
            return 55.0
       }
   }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     
             let spacing:Double = 5.0
        let sectionMessages:MessagesModel = messListArray[section];

        
            let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.mytableView.frame.size.width), height: headerHeight))
            vi.backgroundColor = UIColor.lightGray
        
        let lbl1 = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.mytableView.frame.size.width), height: (headerHeight-(3*spacing))))
        lbl1.text = sectionMessages.sendername;
        lbl1.textAlignment = .left
        vi.addSubview(lbl1)
        
        let lbl2 = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.mytableView.frame.size.width), height: (headerHeight-(7*spacing))))
        lbl2.text = sectionMessages.dateofmessage;
        lbl2.font = lbl2.font.withSize(10)
        lbl2.textAlignment = .center
        vi.addSubview(lbl2)
        
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.mytableView.frame.size.width), height: (headerHeight-(spacing))+(spacing*9)))
        lbl.text = sectionMessages.message;
            lbl.textAlignment = .left
//        lbl.numberOfLines = 0
//        lbl.lineBreakMode = .byWordWrapping
//        lbl.frame.size.width = 300
//        lbl.sizeToFit()
            vi.addSubview(lbl)
          return vi
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionMessages:MessagesModel = messListArray[indexPath.section];
        if(indexPath.row<sectionMessages.replymessagesArray.count){
            let cellMessages:MessagesModel = sectionMessages.replymessagesArray[indexPath.row];
       let cell = mytableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessagesTableViewCell
            cell.lblMess.text = cellMessages.message
            cell.lblName.text = cellMessages.sendername
            cell.lblTym.text = cellMessages.dateofmessage
            return cell

        }
        else{
            messageCell = mytableView.dequeueReusableCell(withIdentifier: "reply", for: indexPath) as! ReplyMessageTableViewCell
            messageCell.replyButton.addTarget(self, action: #selector(MessagesViewController.replyBtnAction(sender:)), for: .touchUpInside)
           // messageCell.btnSend.addTarget(self, action: #selector(MessagesViewController.sendmessage(sender:)), for: .touchUpInside)
            messageCell.btnSend.tag = indexPath.section
            messageCell.replyMessage = sectionMessages
                       return messageCell
    }
       }
    func replyBtnAction(sender:UIButton!)-> Void{
        messageCell.replyMessageTxtField.isHidden=false
        messageCell.btnSend.isHidden = false
      
    }
   
}
