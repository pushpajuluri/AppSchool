//
//  StudentMenuViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 7/31/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class StudentMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var myTableVeiw: UITableView!

    var teacherSubArray = [TeacherMySubject]()
    override func viewDidLoad() {
         GetMysubjects()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //API call for getting subjects
    func GetMysubjects() {
        ApiHelper.sharedController().callToGetMysubjects(successblock: { (todayResultMySubjects) in
            print("success")
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            for dict in myNewDictArray{
                self.teacherSubArray.append(TeacherMySubject.parseData(dict: dict))
            }
            
            DispatchQueue.main.async {
                self.myTableVeiw.reloadData()
            }
            
        },FailureBlock: nil,viewController: self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return teacherSubArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTableVeiw.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyScheduleCellTableViewCell
        let  techObj = self.teacherSubArray[indexPath.row]
        cell.lblTeacherSubj.text = techObj.subjectname
        cell.lblTeacherClass.text = String(techObj.gradeid)+String(describing: techObj.sectionname)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       let  studentMenuObj = self.teacherSubArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mysubjectsViewController = storyboard.instantiateViewController(withIdentifier: "MySubjectsViewController") as! MySubjectsViewController
        mysubjectsViewController.techerSelectedSubject = studentMenuObj
        self.navigationController?.pushViewController(mysubjectsViewController, animated: true)
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


