//
//  TeacherTestAddMarksViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/21/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class TeacherTestAddMarksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var lblSub: UILabel!

    @IBOutlet weak var lblClass: UILabel!
    var selectedTestObj:TestListModel!
    @IBOutlet weak var myTableview: UITableView!
    
    var selectedTextField:UITextField!
    var entermarksArray = [enterMarksModel]()
    var valueToPass:String!
    var markstext:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
       lblSub.text = SharedClass.sharedInstance.teacherSelectedSubject.subjectname
        lblClass.text = String(SharedClass.sharedInstance.teacherSelectedSubject.gradenumber) + String(SharedClass.sharedInstance.teacherSelectedSubject.sectionname) + "class"
        //api call
    enterMarks(selectedTestsObj: selectedTestObj)
           // Do any additional setup after loading the view.
    }
    
    func enterMarks(selectedTestsObj: TestListModel)  {
    selectedTestObj = selectedTestsObj
        ApiHelper.sharedController().callToEnterMarks(selectedTestObj: selectedTestObj,successblock: { (Result) in
            print("Get entermarks response \(Result)")
            if(Result  != nil){
            let  myNewDictArray = Result as! Array<Dictionary<String, Any>>
                if(myNewDictArray.count != 0){
            for dict in myNewDictArray{
                self.entermarksArray.append(enterMarksModel.parseData(dict: dict))
            }
                }
            }
            DispatchQueue.main.async {
                self.myTableview.reloadData()
            }
        }, FailureBlock: nil, viewController: self)
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entermarksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EnterMarksTableViewCell
        let entermarksObj = self.entermarksArray[indexPath.row]
        cell.lblName.text = entermarksObj.name
        cell.lblId.text =  "Id :" + String(entermarksObj.studentid!)
        if(entermarksObj.maxmarks != nil){
            cell.txtMax.text = String(entermarksObj.maxmarks)
        }
              cell.txtMax.textAlignment = .center
          cell.txtMax.layer.borderWidth = 1
         cell.txtMax.layer.borderColor = UIColor.black.cgColor
        cell.txtObt.textAlignment = .center
        cell.txtObt.layer.borderWidth = 1
        cell.txtObt.layer.borderColor = UIColor.black.cgColor
        if(entermarksObj.marks != nil){
        cell.txtObt.text = String(entermarksObj.marks!)
        }
        cell.txtObt.tag = indexPath.row
        //cell.txtObt.addTarget(self, action: #selector(marksentered(sender:)), for: UIControlEvents.editingChanged)
        // entermarksObj.enteredMarks = cell.txtObt.text
        return cell
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let txtfieldstr=textField.text?.appending(string)
        let entermarksObj = self.entermarksArray[textField.tag]
        entermarksObj.marks = Int(txtfieldstr!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)  {
        let entermarksObj = self.entermarksArray[textField.tag]
        entermarksObj.marks =  Int(textField.text!)

       // print("textFieldDidEndEditing \(textField.text)")

    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField){
        self.selectedTextField = textField
        print("textFieldDidBeginEditing \(textField.text)")
    }
   
    
    
    @IBAction func saveMarks(_ sender: Any) {
        
        
            self.selectedTextField.resignFirstResponder()
           
        //Prepare body
        var bodyArray = [[String:Any]]()
        for i in 0..<self.entermarksArray.count {
            let entermarksObj = self.entermarksArray[i]
            
            let aDict = ["classid":entermarksObj.classid ?? "","testid":entermarksObj.testid as Any,"subjectid":entermarksObj.subjectid!,"studentid":entermarksObj.studentid ?? "","marks":entermarksObj.marks ?? 0] as [String : Any]
          
            bodyArray.append(aDict)
        }
        
        ApiHelper.sharedController().callToSaveMarks(bodyArray: bodyArray,successblock: { (todayResult) in
            print("marks are saved  response \(todayResult!)")
            let message = todayResult!["message"]
            self.showToast(message:  (message as! String))
        },FailureBlock: nil, viewController: self)

    }

}
