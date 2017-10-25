//
//  AllWorkSheetViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/17/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class AllWorkSheetViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var btnAddWS: UIButton!
    @IBAction func btnAddWs(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = storyboard.instantiateViewController(withIdentifier: "AddWorkSheetViewController") as! AddWorkSheetViewController
        SharedClass.sharedInstance.superViewController.navigationController?.pushViewController(vc1, animated: true)

    }
    var assignedworksheetArray = [AssignedworksheetslistModel]()
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
        if(SharedClass.sharedInstance.teacherSelectedSubject.subjectname == "Class Teacher")
        {
            btnAddWS.isHidden = true
        }
        else{
            btnAddWS.isHidden = false
        }
        }
            else{
                btnAddWS.isHidden = true
            }
        
        
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //API call to get teacherworksheet
    func getworksheetDetails()  {
        self.assignedworksheetArray.removeAll()
        ApiHelper.sharedController().CallToGetWorksheet(successblock: { (Result) in
            print("Get worksheet \(Result!)")
            let  myNewDictArray = Result
            for dict in myNewDictArray!{
                self.assignedworksheetArray.append(AssignedworksheetslistModel.parseData(dict: dict))
                //todayAttendenceOfStudent()
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }

        }, FailureBlock: nil, viewController: self)
    }
    
    //API call to get teacherworksheet for class
    func getworksheetDetailsClass()  {
        self.assignedworksheetArray.removeAll()
        ApiHelper.sharedController().CallToGetWorksheetClass(successblock: { (Result) in
            print("Get worksheet for class \(Result!)")
            let  myNewDictArray = Result
            for dict in myNewDictArray!{
                self.assignedworksheetArray.append(AssignedworksheetslistModel.parseData(dict: dict))
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
            
        }, FailureBlock: nil, viewController: self)
    }

    //API call to get teacherworksheet for child
    func getworksheetDetailsChild()  {
        self.assignedworksheetArray.removeAll()
        ApiHelper.sharedController().CallToGetWorksheetChild(successblock: { (Result) in
            print("Get worksheet for child \(Result!)")
            let  myNewDictArray = Result
            for dict in myNewDictArray!{
                self.assignedworksheetArray.append(AssignedworksheetslistModel.parseData(dict: dict))
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
            
        }, FailureBlock: nil, viewController: self)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignedworksheetArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorkSheetTableViewCell
        let worksheetObj = self.assignedworksheetArray[indexPath.row]
       cell.lblEndDate.text = worksheetObj.worksheetduedate
       let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        cell.lblLink.text = worksheetObj.worksheetpath
        cell.lblLink.tag = indexPath.row
        cell.lblLink.isUserInteractionEnabled = true
        cell.lblLink.addGestureRecognizer(tap)
        cell.lblLssnName.text = worksheetObj.lessonname
        cell.lblStartDate.text = worksheetObj.dateofassigned
        if(worksheetObj.tags != nil)
        {
            cell.lblTag.text =  worksheetObj.tags!
        }
        else{
            cell.lblTag.text = " No tags"
        }

        cell.lblWSName.text = worksheetObj.worksheetname
        cell.lblWSName.numberOfLines = 0
        cell.lblWSName.lineBreakMode = .byWordWrapping
        cell.lblWSName.frame.size.width = 300
        cell.lblWSName.sizeToFit()
        
        return cell
        
        
    }
    func tapFunction(sender:UITapGestureRecognizer) {
    
        let worksheetObj = self.assignedworksheetArray[sender.view!.tag]

         UIApplication.shared.openURL(NSURL(string: worksheetObj.worksheetpath!)! as URL)
        
    }
    


}
