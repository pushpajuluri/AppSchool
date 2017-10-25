//
//  TimeLineDetailViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/11/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TimeLineDetailViewController: UIViewController {

   
   
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var  timeLineIndividualDetailsViewController:TimeLineIndividualDetailsViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = storyboard.instantiateViewController(withIdentifier: "TimeLineIndividualDetailsViewController") as! TimeLineIndividualDetailsViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
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
         //self.navigationController?.isNavigationBarHidden = true
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView()
    {
        setupSegmentedControl()
        updateView()
    }
    
    private func updateView()
    {
        
       // addWorkSheetViewController.view.addSubview(self.view)
        
        timeLineIndividualDetailsViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        addAssignmentViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 1)
        addWorkSheetViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 2)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Add Lesson", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Add Assignment", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Add Worksheet", at: 2, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
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
   
}
