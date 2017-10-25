//
//  AllAssignmentViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/17/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class AllAssignmentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    var assignedassignmentArray = [AssignedAssignmentModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
        if(SharedClass.sharedInstance.teacherSelectedSubject.subjectname == "Class Teacher")
        {
            btnAddassgn.isHidden = true
        }
        else{
            btnAddassgn.isHidden = false
        }
        }
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var btnAddassgn: UIButton!
    @IBAction func btnAddassgn(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = storyboard.instantiateViewController(withIdentifier: "AddAssignmentViewController") as! AddAssignmentViewController
        SharedClass.sharedInstance.superViewController.navigationController?.pushViewController(vc1, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //API call to get teacherassignment for subject
    func getassignmentDetailsSubject()  {
        self.assignedassignmentArray.removeAll()
        ApiHelper.sharedController().CallToGetAssignments(successblock: { (Result) in
            print("Get assignment subject \(Result!)")
            let  myNewDictArray = Result
            for dict in myNewDictArray!{
                self.assignedassignmentArray.append(AssignedAssignmentModel.parseData(dict: dict))
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }, FailureBlock: nil, viewController: self)
    }
    
    //API call to get teacherassignment for class
    func getassignmentDetailsClass()  {
        self.assignedassignmentArray.removeAll()
        ApiHelper.sharedController().CallToGetAssignmentsClass(successblock: { (Result) in
            print("Get assignment class \(Result!)")
            let  myNewDictArray = Result
            for dict in myNewDictArray!{
                self.assignedassignmentArray.append(AssignedAssignmentModel.parseData(dict: dict))
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }, FailureBlock: nil, viewController: self)
    }
    
    //API call to get assignments for child
    func getassignmentDetailsChild()  {
        self.assignedassignmentArray.removeAll()
        ApiHelper.sharedController().CallToGetAssignmentsChild(successblock: { (Result) in
            print("Get assignment class \(Result!)")
            let  myNewDictArray = Result
            for dict in myNewDictArray!{
                self.assignedassignmentArray.append(AssignedAssignmentModel.parseData(dict: dict))
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }, FailureBlock: nil, viewController: self)
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignedassignmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AssignmentTableViewCell
        let assignmentObj = self.assignedassignmentArray[indexPath.row]
        cell.lblAssignment.text = assignmentObj.assignmentname
        cell.lblDueDate.text = assignmentObj.assignmentduedate
        cell.lblStartDate.text = assignmentObj.dateofassigned
        cell.lblTag.text = assignmentObj.tags
        
        return cell
        
       
    }

}
