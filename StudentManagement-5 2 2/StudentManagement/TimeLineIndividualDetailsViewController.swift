//
//  TimeLineIndividualDetailsViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/17/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TimeLineIndividualDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    var TimeLineArray =  [TimeLineModel]()
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var lblSubject: UILabel!
    
    @IBOutlet weak var lblStartDate: UILabel!
    
    @IBOutlet weak var lblLesson: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var lblTag: UILabel!
    
    var techerSelectedTimeLine:TimeLineModel!
    let headerHeight:Double = 70.0
    
    
    lazy  var  addWorkSheetViewController:AddWorkSheetViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = storyboard.instantiateViewController(withIdentifier: "AddWorkSheetViewController") as! AddWorkSheetViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy  var  addAssignmentViewController:AddAssignmentViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = storyboard.instantiateViewController(withIdentifier: "AddAssignmentViewController") as! AddAssignmentViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lblSubject.text = SharedClass.sharedInstance.techerSelectedTimeLine.subjectname ?? ""
        lblStartDate.text = SharedClass.sharedInstance.techerSelectedTimeLine.lessonstartdate ?? ""
        lblLesson.text = SharedClass.sharedInstance.techerSelectedTimeLine.lessonname ?? ""
        if(SharedClass.sharedInstance.techerSelectedTimeLine.status != nil)
        {
            lblStatus.text = SharedClass.sharedInstance.techerSelectedTimeLine.status ?? "No Status"
        }
        if(SharedClass.sharedInstance.techerSelectedTimeLine.tags != nil)
        {
            lblTag.text = SharedClass.sharedInstance.techerSelectedTimeLine.tags ?? "No Tag"
        }
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
            if(SharedClass.sharedInstance.teacherSelectedSubject.subjectname == "Class Teacher"){
                segmentedControl.isHidden = true
    
            }else{
                segmentedControl.isHidden = false
                setupView()
            }
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func setupView()
    {
        setupSegmentedControl()
        updateView()
    }
    
    private func updateView()
    {
        
        // addWorkSheetViewController.view.addSubview(self.view)
        
       
        addAssignmentViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        addWorkSheetViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 1)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
       
        segmentedControl.insertSegment(withTitle: "Add Assignment", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Add Worksheet", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        //segmentedControl.selectedSegmentIndex = 0
    }
    func selectionDidChange(sender:UISegmentedControl){
        updateView()
    }
    
    func addViewControllerAsChildViewController(childViewController: UIViewController) {
        // addChildViewController(childViewController)
        self.view.addSubview(childViewController.view)
        childViewController.view.frame = CGRect(x: 0, y: 150, width: self.view.frame.width, height: self.view.frame.height - 150)
        //childViewController.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        //  childViewController.didMove(toParentViewController: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 1{
            return techerSelectedTimeLine.assignmentArray.count
           
        }
        if section == 2{
           return techerSelectedTimeLine.wsArray.count
          
        }
      //  let  assignObj:TimeLineModel = TimeLineArray[section]
        return TimeLineArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1{
            let spacing:Double = 5.0
            
            let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight))
         //   vi.backgroundColor = UIColor.lightGray
            
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
            lbl.text = "Worksheet"
            lbl.textColor = UIColor.blue
            lbl.textAlignment = .center
            vi.addSubview(lbl)
            return vi
        }
        else
        {
            let spacing:Double = 5.0
            
            let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: self.headerHeight))
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
            lbl.text = "Assignment"
            lbl.textColor = UIColor.blue
            lbl.textAlignment = .center
            vi.backgroundColor = UIColor.white
            vi.addSubview(lbl)
            return vi
        }

    }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(headerHeight)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        if(indexPath.section == 0)
        {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CellAssign", for: indexPath) as!  TimeLineAssignTableViewCell
        let  timelineObj = self.TimeLineArray[indexPath.row]
            if(timelineObj.assignmentArray.count == 0){
            tableView.isHidden = true
            }else{
                tableView.isHidden = false
                let assignObj = timelineObj.assignmentArray[indexPath.row]
                // cell.lblAssgn.text = "pushpa"
                cell.lblAssgn.text = assignObj.assignmentname
                cell.lblEndDate.text = assignObj.assignmentduedate
                cell.lblStartDate.text = assignObj.dateofassigned
                cell.lblTag.text = assignObj.tags
                return cell
            }
            return cell
        }
    
         if (indexPath.section == 1)
        {
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!  TimeLineWSTableViewCell
            
            if TimeLineArray.count < indexPath.row {
                let  timelineObj = self.TimeLineArray[indexPath.row]
                if(timelineObj.wsArray.count > 0){
                    let wsObj = timelineObj.wsArray[indexPath.row]
                    cell.lblLessName.text = wsObj.lessonname
                    cell.lblLink.text = wsObj.worksheetpath
                    cell.lblTag.text = wsObj.tag
                    cell.lblWS.text = wsObj.worksheetname
                    return cell
                }else{
                    
                }
            }
        return cell
        }
     return cell
}
    


}
