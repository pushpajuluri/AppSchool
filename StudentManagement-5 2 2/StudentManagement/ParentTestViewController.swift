//
//  ParentTestViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 9/21/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class ParentTestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var parentSelectedClass:ChildMySubject!
    let headerHeight:Double = 120.0
    @IBOutlet weak var myTableView: UITableView!
var testListArray =  [TestListModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
if(SharedClass.sharedInstance.userrole == "PARENT")
{
    TestListOfStudentofChild(parentSelectedClass:SharedClass.sharedInstance.parentSelectedChild)
        }
else{
    TestListOfStudentofClass(techerSelectedClassValue: SharedClass.sharedInstance.teacherSelectedSubject)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Api Call for getting test list of child
    func TestListOfStudentofChild(parentSelectedClass:ChildMySubject)  {
        SharedClass.sharedInstance.parentSelectedChild=parentSelectedClass
        self.testListArray.removeAll()
        ApiHelper.sharedController().callToGetTestListForChild(parentSelectedClass:parentSelectedClass,successblock: { (Result) in
            print("Get test list response of my child \(Result)")
            let  myNewDictArray = Result as! Array<Dictionary<String, Any>>
            for dict in myNewDictArray{
                self.testListArray.append(TestListModel.parseData(dict: dict))
            }
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }, FailureBlock: nil, viewController: self)
    }
    
    func TestListOfStudentofClass(techerSelectedClassValue:TeacherMySubject)  {
        self.testListArray.removeAll()
        ApiHelper.sharedController().callToGetTestListForClass(techerSelectedSubject: SharedClass.sharedInstance.teacherSelectedSubject,successblock: { (Result) in
            print("Get test list response of my class \(Result)")
            let  myNewDictArray = Result as! Array<Dictionary<String, Any>>
            for dict in myNewDictArray{
                self.testListArray.append(TestListModel.parseData(dict: dict))
            }
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }, FailureBlock: nil, viewController: self)
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return testListArray.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = Bundle.main.loadNibNamed("ParentTestsTableViewCell", owner: self, options: nil)?.first as! ParentTestsTableViewCell
         let  testListObj = self.testListArray[section]
        headerCell.lblTst.text = testListObj.testtype
        headerCell.lblendDate.text = testListObj.enddate
        headerCell.lblStrDate.text = testListObj.startdate
        headerCell.lblMaxMarks.text = "Max Marks:" + String(testListObj.maxmarks)
        headerCell.lblTstMode.text = testListObj.testmode
        headerCell.backgroundColor = UIColor.lightGray
        
        headerCell.btnViewRslt.addTarget(self, action: #selector(addmarks), for: .touchUpInside)
        headerCell.btnViewRslt.tag = section

        return headerCell
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return CGFloat(headerHeight)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let  testListObj = self.testListArray[section]
      //  let subobj = testListObj.subjectsArray[section]
        return testListObj.subjectsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChildSubjectsTableViewCell
        let  testListObj = self.testListArray[indexPath.section]
          let subobj = testListObj.subjectsArray[indexPath.row]
        if(subobj.maxmarks == nil){
            
        }else{
       cell.lblMax.text = "Max Marks: " + String(subobj.maxmarks!)
        }
     cell.lblSub.text = "Subject Name: " + subobj.subjectname!
        if subobj.syllabus == nil{
            
        }else{
            cell.lblSyll.text = "Syllabus: " + subobj.syllabus!
        }
        return cell
    }
    func addmarks(btn:UIButton){
        let  selectedTestObj = self.testListArray[btn.tag]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testViewController = storyboard.instantiateViewController(withIdentifier: "TeacherTestViewResultsViewController") as! TeacherTestViewResultsViewController
        testViewController.selectedTestObj = self.testListArray[btn.tag]
        self.navigationController?.pushViewController(testViewController, animated: true)
    }
}
