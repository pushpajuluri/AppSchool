//
//  StudentsViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 6/5/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
     @IBOutlet weak var tableView: UITableView!
    var selectedSectionObject:Section!
    var sectionID: String = ""
    var studentArray = [Student]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Students"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add student", style: .plain, target: self, action: #selector(StudentsViewController.addstudentTapped))
        
      
        // Do any additional setup after loading the view.
    }
    func addstudentTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addStudentViewController = storyboard.instantiateViewController(withIdentifier: "AddStudentViewController") as! AddStudentViewController
        addStudentViewController.selectedStudentObject = selectedSectionObject
        self.navigationController?.pushViewController(addStudentViewController, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        //Getting list of student
        //studentArray = DataBaseHelper.sharedController().getListOfStudents(sectionId:selectedSectionObject.sectionId!)
        //self.tableView.reloadData()
        

        print("student list are \(self.studentArray)")

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let studentobj = self.studentArray[indexPath.row]
        print(studentobj.studentName)

        cell.textLabel?.text = "\(studentobj.studentName)".capitalized
       
        
        
        return cell
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
