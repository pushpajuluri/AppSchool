//
//  TeacherTestViewResultsViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 9/19/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TeacherTestViewResultsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var lblTestType: UILabel!
    @IBOutlet weak var lblMaxMarks: UILabel!
 var selectedTestObj:TestListModel!
    
    @IBOutlet weak var myTableView: UITableView!
    var viewMarksArray = [ViewReultsModel]()
let headerHeight:Double = 30.0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        lblTestType.text = "Test Name :"+selectedTestObj.testtype!
        lblMaxMarks.text = "Max Marks :"+String(selectedTestObj.maxmarks)
        if(SharedClass.sharedInstance.userrole == "TEACHER"){
       callToViewMarks(selectedTestsObj: selectedTestObj)
        }else{
            callToViewMarksChild(selectedTestsObj: selectedTestObj)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  // api call to view result
    func callToViewMarks(selectedTestsObj: TestListModel)  {
        selectedTestObj = selectedTestsObj
        ApiHelper.sharedController().callToViewMarks(selectedTestObj: selectedTestObj,successblock: { (Result) in
            print("Get view marks response \(Result)")
            if(Result  != nil){
            let  myNewDictArray = Result as!   Dictionary<String, Any>
            self.viewMarksArray.append(ViewReultsModel.parseData(dict: myNewDictArray))
        }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
        }
        }, FailureBlock: nil, viewController: self)
    }
    
    // api call to view result for child
    func callToViewMarksChild(selectedTestsObj: TestListModel)  {
        selectedTestObj = selectedTestsObj
        ApiHelper.sharedController().callToViewMarksChild(selectedTestObj: selectedTestObj,successblock: { (Result) in
            print("Get view marks response for child \(Result)")
                                   if(Result  != nil){
            let  myNewDictArray = Result as!   Dictionary<String, Any>
            self.viewMarksArray.append(ViewReultsModel.parseData(dict: myNewDictArray))
                       }
                        DispatchQueue.main.async {
                            self.myTableView.reloadData()
                        }
        }, FailureBlock: nil, viewController: self)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let transfer = viewMarksArray[section]
        if(transfer.resultstransferArray.count != 0){
            
        }
        return transfer.resultstransferArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewMarksArray.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(headerHeight)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let transfer = viewMarksArray[section]
        if (transfer.resultstransferArray.count > 0) {
            let student = transfer.resultstransferArray[section]
            let spacing:Double = 5.0
            let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.myTableView.frame.size.width), height: headerHeight))
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.myTableView.frame.size.width), height: headerHeight-spacing))
            lbl.text = student.name!+" "   + "Id:"+String(student.studentid!)
            lbl.textColor = UIColor.blue
            lbl.textAlignment = .center
            vi.addSubview(lbl)
            return vi
        }
        else{
        let vi = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        return vi
        }
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ViewMarksTableViewCell
        let viewmarksObj = self.viewMarksArray[indexPath.section]
        let resulttranferObj = viewmarksObj.resultstransferArray[indexPath.row]
      //   if  viewmarksObj.resultstransferArray.count < indexPath.row{
        let subObj = resulttranferObj.studentsubjectmarksArray[indexPath.row]
        if(subObj.marks != nil){
        cell.lblMrks.text = String(subObj.marks!)
        }
        cell.lblSubName.text = subObj.subjectname
    //d    }
 return cell
}
}
