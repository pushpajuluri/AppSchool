//
//  MasterViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/17/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController,UIPickerViewDataSource{

    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var slctClassPicker: UIPickerView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var techerSelectedClass:TeacherMySubject!
    var teacherSubArray = [TeacherMySubject]()
     var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
    lazy var  timelineViewController:TimeLineViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = storyboard.instantiateViewController(withIdentifier: "TimeLineViewController") as! TimeLineViewController
      //  UINavigationController(viewController)
       
       // let navigationController = UINavigationController(rootViewController: viewController)
       // self.present(navigationController, animated: true, completion: nil)
        return viewController
    }()
    
    lazy  var  allassignmentViewController:AllAssignmentViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = storyboard.instantiateViewController(withIdentifier: "AllAssignmentViewController") as! AllAssignmentViewController
         return viewController
    }()
    
    lazy  var  allworksheetViewController:AllWorkSheetViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = storyboard.instantiateViewController(withIdentifier: "AllWorkSheetViewController") as! AllWorkSheetViewController
         return viewController
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
     //  lblClass.layer.borderWidth = 2.0
        super.viewDidLoad()
        
        SharedClass.sharedInstance.superViewController=self

        //self.navigationController?.isNavigationBarHidden = true
      //  getMysubjects()
        
        slctClassPicker.reloadAllComponents()
        
        tapGesture.numberOfTapsRequired = 1
//        lblClass.addGestureRecognizer(tapGesture)
//        lblClass.isUserInteractionEnabled = true
        tapGesture.addTarget(self, action: #selector( tempMethod))
        slctClassPicker.isHidden=true
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
        if(SharedClass.sharedInstance.teacherSelectedSubject.subjectname != "Class Teacher"){
        self.timelineViewController.callToGetTimeLineOfMysubject(techerSelectedClassValue: SharedClass.sharedInstance.teacherSelectedSubject)
            self.allassignmentViewController.getassignmentDetailsSubject()
            self.allworksheetViewController.getworksheetDetails()
        }
        else{
            self.timelineViewController.callToGetTimeLineOfMyclass(techerSelectedClassValue: SharedClass.sharedInstance.teacherSelectedSubject)
            self.allworksheetViewController.getworksheetDetailsClass()
            self.allassignmentViewController.getassignmentDetailsClass()
        }
       
        }
        else{
            self.timelineViewController.callToGetTimeLineOfMychild(parentSelectedClass: SharedClass.sharedInstance.parentSelectedChild)
            self.allassignmentViewController.getassignmentDetailsChild()
            self.allworksheetViewController.getworksheetDetailsChild()
        }
        
        self.setupView()
        
        self.addViewControllerAsChildViewController(childViewController:self.allassignmentViewController)
        self.addViewControllerAsChildViewController(childViewController:self.allworksheetViewController)
        self.addViewControllerAsChildViewController(childViewController:self.timelineViewController)
        
    }
    func tempMethod()
    {
        slctClassPicker.isHidden = false
        self.view.bringSubview(toFront: self.slctClassPicker)
    }
    
    //api call to get subjects
    func getMysubjects() {
        ApiHelper.sharedController().callToGetMysubjects(successblock: { (todayResultMySubjects) in
            print("success")
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            
            for dict in myNewDictArray{
                self.teacherSubArray.append(TeacherMySubject.parseData(dict: dict))
                //todayAttendenceOfStudent()
            }
            
            if(self.teacherSubArray.count>0){
               
                let classname =  self.teacherSubArray[0]
                self.lblClass.text = String(classname.gradenumber)+classname.sectionname
                self.slctClassPicker.isHidden = false
                self.view.bringSubview(toFront: self.slctClassPicker)
                self.slctClassPicker.reloadAllComponents()
                SharedClass.sharedInstance.teacherSelectedSubject = classname
            }
            
//            self.setupView()
//            
//             self.addViewControllerAsChildViewController(childViewController:self.allassignmentViewController)
//            self.addViewControllerAsChildViewController(childViewController:self.allworksheetViewController)
//            self.addViewControllerAsChildViewController(childViewController:self.timelineViewController)

            
        },FailureBlock: nil,viewController: self)
    }
    
    //picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teacherSubArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        let classname = teacherSubArray[row];
        //    let selected = String(classname.gradeid)+classname.sectionname
        return String(classname.gradenumber)+classname.sectionname
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.slctClassPicker.isHidden = true
        let classname =  teacherSubArray[row]
        self.lblClass.text = String(classname.gradenumber)+classname.sectionname
        SharedClass.sharedInstance.teacherSelectedSubject = classname
        SharedClass.sharedInstance.p = row
        
//        self.timelineViewController.callToGetTimeLineOfMysubject(techerSelectedClassValue: classname)
//        self.allassignmentViewController.getassignmentDetailsSubject()
//        self.allworksheetViewController.getworksheetDetails()
       // self.callToGetTimeLineOfMysubject(techerSelectedClassValue: self.teacherSubArray[SharedClass.sharedInstance.p])
    }

    
    private func setupView()
    {
        setupSegmentedControl()
        updateView()
    }
    
    private func updateView()
    {
        // addWorkSheetViewController.view.addSubview(self.view)
        
        timelineViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        allworksheetViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 1)
        allassignmentViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 2)
        if(segmentedControl.selectedSegmentIndex==0){
           // timelineViewController.getMysubjects()
        }
        else  if(segmentedControl.selectedSegmentIndex==1){
        //  self.allworksheetViewController.getMysubjects()
        }
        
        else  if(segmentedControl.selectedSegmentIndex==2){
         }


        
        
    }
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "All Lesson", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "All Worksheet", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "All Assignment", at: 2, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
    }
    func selectionDidChange(sender:UISegmentedControl){
        updateView()
    }
    
    func addViewControllerAsChildViewController(childViewController: UIViewController) {
        // addChildViewController(childViewController)
        self.view.addSubview(childViewController.view)
        childViewController.view.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height - 150)
        //childViewController.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        //  childViewController.didMove(toParentViewController: self)
    }


}
