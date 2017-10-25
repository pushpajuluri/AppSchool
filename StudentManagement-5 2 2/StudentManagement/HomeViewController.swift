//
//  HomeViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 6/1/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var classesArray = [Classes]()
    
    override func viewDidLoad() {
        self.title = "Classes"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Class", style: .plain, target: self, action: #selector(HomeViewController.addClassTapped))
       let schoolname =  GlobalVariable.sharedController().loginDetails?.resSchool
        print("my school name\(schoolname)")

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Getting list of classes
        classesArray = DataBaseHelper.sharedController().getListOfClasses()
        print("Classes list are \(self.classesArray)")
        self.tableView.reloadData()
    }
    
    func addClassTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addClassViewController = storyboard.instantiateViewController(withIdentifier: "AddClassViewController") as! AddClassViewController
        self.navigationController?.pushViewController(addClassViewController, animated: true)
    }
    
    //MARK: UITableView data source methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return classesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ClassesCell
        
        let classObj = self.classesArray[indexPath.row]
        
        cell.lblClassname!.text = "\(classObj.classname!)".capitalized
       
        //fill the list of sections in scroll view
        addSections(scrollView: cell.scrollView, classObj: classObj,indexPath: indexPath)
        
        //Add section 
        cell.btnAdd.tag = indexPath.row
        cell.btnAdd.addTarget(self, action: #selector(HomeViewController.addSection), for: .touchUpInside)
        
        
        return cell
    }
    
    func addSections(scrollView:UIScrollView,classObj:Classes,indexPath:IndexPath) {
        //Removing all subviews in scrollView
        for vi in scrollView.subviews {
            vi.removeFromSuperview()
        }
        
        let spacing = 10.0
        var x = 0.0
        let buttonWidth = Double(scrollView.frame.size.height)
        for section in classObj.sections! {
            
            
            
            
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: x, y: 0.0, width: buttonWidth, height: buttonWidth)
            btn.backgroundColor = UIColor.purple
            btn.setTitle((section as! Section).sectionName, for: .normal)
            scrollView.addSubview(btn)
            btn.accessibilityHint = (section as! Section).sectionId
            btn.tag = indexPath.row
            
            btn.addTarget(self, action: #selector(HomeViewController.sectionTapped), for: .touchUpInside)
            
            x += (spacing + buttonWidth)
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(Float(x)), height: scrollView.frame.size.height )
        
    }
    
    //MARK: TAble View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sectionsViewController = storyboard.instantiateViewController(withIdentifier: "SectionsViewController") as! SectionsViewController
        self.navigationController?.pushViewController(sectionsViewController, animated: true)  */
    }
    
    //Add section
    func addSection(btn:UIButton)
    {
        print("tapped number \(btn.tag)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addClassViewController = storyboard.instantiateViewController(withIdentifier: "AddSectionViewController") as! AddSectionViewController
        addClassViewController.selectedClassObject = self.classesArray[btn.tag]
        
        
        self.navigationController?.pushViewController(addClassViewController, animated: true)

    }
    
    func sectionTapped(btn:UIButton) {
        let classRowNo = btn.tag
        let sectionId = btn.accessibilityHint
        let classObj = self.classesArray[btn.tag]
       
        var selectedSection:Section!
        for section in classObj.sections! {
            if (section as! Section).sectionId == sectionId {
                selectedSection = (section as! Section)
                break
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let studentsViewController = storyboard.instantiateViewController(withIdentifier: "StudentsViewController") as! StudentsViewController
        studentsViewController.selectedSectionObject = selectedSection
        studentsViewController.sectionID = selectedSection.sectionId!
        self.navigationController?.pushViewController(studentsViewController, animated: true)
        
    
    }
}
