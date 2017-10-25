//
//  TimeLineViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/7/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
 
    @IBOutlet weak var imgAssg: UIImageView!
    var techerSelectedClass:TeacherMySubject!
    var parentSelectedClass:ChildMySubject!
    var teacherSubArray = [TeacherMySubject]()
    var TimeLineArray =  [TimeLineModel]()
    var tempclassname:TeacherMySubject?
    var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var lblClass: UILabel!
   
    
    @IBAction func btnDetail(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "AddLessonViewController") as! AddLessonViewController
        SharedClass.sharedInstance.superViewController.navigationController?.pushViewController(vc1, animated: true)
        
    }
    @IBOutlet weak var btnDetail: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
        if(SharedClass.sharedInstance.teacherSelectedSubject.subjectname == "Class Teacher")
        {
            btnDetail.isHidden = true
        }
        else{
            btnDetail.isHidden = false
        }
        }
        else{
            btnDetail.isHidden = true
        }
              // getMysubjects()
          self.view.bringSubview(toFront: btnDetail)
    }
    
    
    func tempMethod()
    {
        dropDown.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //api call to get subjects
    func getMysubjects() {
        ApiHelper.sharedController().callToGetMysubjects(successblock: { (todayResultMySubjects) in
            print("success")
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            
            for dict in myNewDictArray{
                self.teacherSubArray.append(TeacherMySubject.parseData(dict: dict))
                
            }
            
            if(self.teacherSubArray.count>0){
                self.callToGetTimeLineOfMysubject(techerSelectedClassValue: self.teacherSubArray.first!)
            
            }
            
        },FailureBlock: nil,viewController: self)
    }
 
    //call to get timeline of subjects
    func callToGetTimeLineOfMysubject(techerSelectedClassValue:TeacherMySubject) {
        SharedClass.sharedInstance.teacherSelectedSubject=techerSelectedClassValue
        techerSelectedClass = techerSelectedClassValue
    
       self.TimeLineArray.removeAll()
        ApiHelper.sharedController().callToGetTimeLineOfMysubject(techerSelectedSubject: techerSelectedClass,successblock: { (todayResult) in
            print("Get timeline  response \(todayResult!)")
         
            let  myNewDictArray = todayResult as! Array<Dictionary<String, Any>>
           
            for dict in myNewDictArray{
                self.TimeLineArray.append(TimeLineModel.parseData(dict: dict))
            }

            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        },FailureBlock: nil, viewController: self)
    }
    
    func callToGetTimeLineOfMyclass(techerSelectedClassValue:TeacherMySubject) {
        SharedClass.sharedInstance.teacherSelectedSubject=techerSelectedClassValue
        techerSelectedClass = techerSelectedClassValue
        
        self.TimeLineArray.removeAll()
        ApiHelper.sharedController().callToGetTimeLineClass(techerSelectedSubject: techerSelectedClass,successblock: { (todayResult) in
            print("Get timeline  response class\(todayResult!)")
            
            let  myNewDictArray = todayResult as! Array<Dictionary<String, Any>>
            
            for dict in myNewDictArray{
                self.TimeLineArray.append(TimeLineModel.parseData(dict: dict))
            }
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        },FailureBlock: nil, viewController: self)
    }

    func callToGetTimeLineOfMychild(parentSelectedClass:ChildMySubject) {
        SharedClass.sharedInstance.parentSelectedChild=parentSelectedClass
                self.TimeLineArray.removeAll()
        ApiHelper.sharedController().callToGetTimeLineChild(parentSelectedClass:parentSelectedClass,successblock: { (todayResult) in
            print("Get timeline  response of child\(todayResult!)")
            
            let  myNewDictArray = todayResult as! Array<Dictionary<String, Any>>
            
            for dict in myNewDictArray{
                self.TimeLineArray.append(TimeLineModel.parseData(dict: dict))
            }
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        },FailureBlock: nil, viewController: self)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeLineArray.count
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TimeLineCell
        let timeLineObj = self.TimeLineArray[indexPath.row]
        
          
        cell.lblLesson.text = timeLineObj.lessonname
        cell.lblLesson.numberOfLines = 0
        cell.lblLesson.lineBreakMode = .byWordWrapping
 
        cell.lblLesson.tintColor = UIColor.green
        if(SharedClass.sharedInstance.userrole == "TEACHER"){
        if(SharedClass.sharedInstance.teacherSelectedSubject.subjectname == "MY CLASS"){
        if (timeLineObj.subjectname != nil){
            cell.lblSubName.text = "Subject:" + timeLineObj.subjectname!
            }
        }
        else{
             cell.lblSubName.text = "Subject:"+SharedClass.sharedInstance.teacherSelectedSubject.subjectname
            }
        }else{
             cell.lblSubName.text = "Subject:" + timeLineObj.subjectname!
        }
        if(timeLineObj.status != nil){
            cell.lblStatus.text = "Status:" + timeLineObj.status!
        }
        else{
            cell.lblStatus.text = "Status: No status"
        }
       if(timeLineObj.lessondescription != nil)
        {
            cell.lbltag.text = "Tags :" + timeLineObj.lessondescription!
            cell.lbltag.numberOfLines = 0
            cell.lbltag.lineBreakMode = .byWordWrapping
            cell.lbltag.frame.size.width = 300
         }
        else{
            cell.lbltag.text = "Tags : No tags"
        }
        
        cell.imgAssg.image = UIImage(named:"assignments-icon-hover.png")
                  cell.lblDate.text = timeLineObj.lessonstartdate
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
            cell.btnPublish.isHidden = false
        cell.btnPublish.tag = indexPath.row
         cell.btnPublish.addTarget(self, action: #selector(publish), for: .touchUpInside)
        }
        
//        if (indexPath.row % 2) != 0{
//            cell.backgroundColor = UIColor.cyan
//        }else{
//            cell.backgroundColor = UIColor .lightGray
//            
//        }
        return cell
    }
    
    func getCurrentMillis()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    func publish(btn:UIButton) {
        let  timelineObj = self.TimeLineArray[btn.tag]
        let bodyArray =  ["notificationname":timelineObj.lessonname,"description":timelineObj.lessondescription,"userid":SharedClass.sharedInstance.userid,"lessonname":timelineObj.lessonname,"actioncode":"Timeline","parentactionrequired":"no","notificationdate":getCurrentMillis(),"classid":SharedClass.sharedInstance.teacherSelectedSubject.id,"id":timelineObj.id] as [String : Any]
        ApiHelper.sharedController().callToPublish(bodyArray: bodyArray,successblock: { (todayResult) in
            let message = todayResult!["message"]
            self.showToast(message:  (message as! String))
            print("publish are saved  response \(todayResult!)")
            
        },FailureBlock: nil, viewController: self)
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let timeLineObj = self.TimeLineArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timelinecontroller = storyboard.instantiateViewController(withIdentifier: "TimeLineIndividualDetailsViewController") as! TimeLineIndividualDetailsViewController
       timelinecontroller.techerSelectedTimeLine = timeLineObj
        timelinecontroller.TimeLineArray = [timeLineObj]
        SharedClass.sharedInstance.techerSelectedTimeLine = timeLineObj
        SharedClass.sharedInstance.superViewController.navigationController?.pushViewController(timelinecontroller, animated: true)
    }

}
