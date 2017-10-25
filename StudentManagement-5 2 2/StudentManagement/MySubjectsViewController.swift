//
//  MySubjectsViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 7/26/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit
class MySubjectModel{
    var subjectimages:UIImage?
    var subjectnames = ""
}

class MySubjectsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    var techerSelectedSubject:TeacherMySubject!
    var parentSelectedChild:ChildMySubject!
    
    @IBOutlet weak var mylabel: UILabel!
   
    @IBOutlet weak var lblSub: UILabel!
    @IBOutlet weak var lblCls: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    fileprivate let noOfItemsInRow = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    
    var subjectarray = [MySubjectModel]()
    
    func getsubjectdetails() -> [MySubjectModel]
    {
      
     let image1 = UIImage(named: "attandance-icon-hover.png")
    //    let image2 = UIImage(named: "assignments-icon-hover.png")
        let image3 = UIImage(named: "timeline-icon-normal.png")
        let image4 = UIImage(named: "tests-icon-normal.png")
     //   let image5 = UIImage(named: "list-simple-7.png")
        let image6  = UIImage(named: "students-icon-normal.png")
        let image7 = UIImage(named:"student.png")
        
//        let subobj = MySubjectModel()
//        subobj.subjectimages = image1
//        subobj.subjectnames = "Dash Board"
//        subjectarray.append(subobj)
//
//        let subobj1 = MySubjectModel()
//        subobj1.subjectimages = image2
//        subobj1.subjectnames = "Messages"
//        subjectarray.append(subobj1)
        
        let subobj2 = MySubjectModel()
        subobj2.subjectimages =  image3
        subobj2.subjectnames = "Time Line"
        subjectarray.append(subobj2)
        
        let subobj4 = MySubjectModel()
        subobj4.subjectimages = image1
        subobj4.subjectnames = "Attendance"
        subjectarray.append(subobj4)

        
        let subobj3 = MySubjectModel()
        subobj3.subjectimages = image4
        subobj3.subjectnames = "Tests"
        subjectarray.append(subobj3)
        
        
        let subobj5 = MySubjectModel()
        subobj5.subjectimages = image6
        subobj5.subjectnames = "Profile"
        subjectarray.append(subobj5)
          if(SharedClass.sharedInstance.userrole == "TEACHER"){
        let subobj7 = MySubjectModel()
        subobj7.subjectimages = image7
        subobj7.subjectnames = "Student List"
        subjectarray.append(subobj7)
        }
          return subjectarray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
      //  self.title = String(selectedObj.gradeid)+String(describing: selectedObj.sectionname)+"    "+String(selectedObj.subjectname)
        if(SharedClass.sharedInstance.userrole == "TEACHER"){
        lblCls.text = "Section :"+String(techerSelectedSubject.gradenumber)+String(describing: techerSelectedSubject.sectionname)
        lblSub.text = techerSelectedSubject.subjectname
        }
        else {
            lblCls.text = "Class :"+String(parentSelectedChild.classid)+String(parentSelectedChild.sectionname)
            lblSub.text = parentSelectedChild.name
        }
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        getsubjectdetails()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjectarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let subobj = self.subjectarray[indexPath.row]
        cell.myImage.image = subobj.subjectimages
        cell.mylbl.text = subobj.subjectnames
        
        // increasing the size of label
                cell.mylbl.numberOfLines = 0
                cell.mylbl.lineBreakMode = .byWordWrapping
                cell.mylbl.frame.size.width = cell.frame.size.width
                cell.mylbl.sizeToFit()
       
        let noc:CGFloat = 3
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, noc - 1)*horizontalSpacing)/noc
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
            cell.layer.cornerRadius = 5.0
            cell.contentMode = .scaleAspectFill
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let subobj = self.subjectarray[indexPath.row]
        
        
        if(indexPath.row == 0)
        {
            let imgDisplayController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MasterViewController") as! MasterViewController
         
            self.navigationController?.pushViewController(imgDisplayController, animated: true)
        }
    
    
    if(indexPath.row == 1)
    {
        if(SharedClass.sharedInstance.userrole == "TEACHER"){
    let imgDisplayController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
    
    self.navigationController?.pushViewController(imgDisplayController, animated: true)
        }else{
            let imgDisplayController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StudentAttendanceViewController") as! StudentAttendanceViewController
            
            self.navigationController?.pushViewController(imgDisplayController, animated: true)
        }
    }
        if(indexPath.row == 3)
        {
            if(SharedClass.sharedInstance.userrole == "TEACHER"){
           let imgDisplayController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeacherProfileViewController") as! TeacherProfileViewController
           self.navigationController?.pushViewController(imgDisplayController, animated: true)
            }
            else{
                let imgDisplayController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StudentProfileViewController") as! StudentProfileViewController
                self.navigationController?.pushViewController(imgDisplayController, animated: true)
            }
        }
        
        if(indexPath.row == 4)
        {
            if(SharedClass.sharedInstance.userrole == "TEACHER") {
          let imgDisplayController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StudentListProfileViewController") as! StudentListProfileViewController
           self.navigationController?.pushViewController(imgDisplayController, animated: true)
            }
        }

        if(indexPath.row == 2)
        {
            if(SharedClass.sharedInstance.userrole == "TEACHER") && (SharedClass.sharedInstance.teacherSelectedSubject.subjectname != "Class Teacher"){
            let imgDisplayController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeacherTestViewController") as! TeacherTestViewController
            
            self.navigationController?.pushViewController(imgDisplayController, animated: true)
            }
            else{
                let imgDisplayController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ParentTestViewController") as! ParentTestViewController
                
                self.navigationController?.pushViewController(imgDisplayController, animated: true)
            

            }
        }
        
       
    
}

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left*(CGFloat(noOfItemsInRow + 1))
        let availableWidth = myCollectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(noOfItemsInRow)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
