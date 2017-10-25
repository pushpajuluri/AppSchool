  //
//  DataBaseHelper.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 6/6/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit
import CoreData

class DataBaseHelper: NSObject {
    let maxstudent = 100
    var studentsobj = "Section"
    
    static var dataBaseHelper = DataBaseHelper()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    class func sharedController()->DataBaseHelper {
       return self.dataBaseHelper
    }
    
    func getListOfClasses() ->[Classes]{
        let context =  appDelegate.getContext()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Classes")
        fetchReq.resultType = .managedObjectResultType
        do {
            let results = try context.fetch(fetchReq)
            print("\(results)")
            return results as! [Classes]
        }
        catch {
            return [Classes]()
        }
      }
    
    func addClassRoom(className:String,totalStudents:String) -> Bool {
        let context = appDelegate.getContext()
        let classEntity = NSEntityDescription.insertNewObject(forEntityName: "Classes", into: context) as! Classes
        classEntity.classname = className
        classEntity.nofs = totalStudents
        
        do {
            try context.save()
            return true
        }
        catch {
            print("unable to add class room")
            return false
        }
    }
    
    func addSectionToClass(classObject:Classes,sectionName:String) -> Bool {
    
    
        let context = appDelegate.getContext()
        let sectionEntity = NSEntityDescription.insertNewObject(forEntityName: "Section", into: context) as! Section
        sectionEntity.sectionName = sectionName
        sectionEntity.sectionId = getUniqueCode()
        classObject.addToSections(sectionEntity)
        
        do {
            try context.save()
            return true
        }
        catch {
            print("unable to add class room")
            return false
        }
    }
    
    func addStudent(sectionObject:Section,studentName:String) -> Bool {
        
        
        let context = appDelegate.getContext()
        let studentEntity = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context) as! Student
        studentEntity.studentName = studentName
        studentEntity.studentId = getUniqueCode()
        sectionObject.addToStudents(studentEntity)
        
        do {
            try context.save()
            return true
        }
        catch {
            print("unable to add class room")
            return false
        }
    }
    
    func getListOfStudents(sectionId:String) ->[Student]{
        let context =  appDelegate.getContext()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Section")
        fetchReq.resultType = .managedObjectResultType
        fetchReq.predicate = NSPredicate(format: "sectionId == %@", sectionId)
        do {
            let results = try context.fetch(fetchReq) as! [Section]
            print("\(results)")
            if results.count > 0 {
                if let sectionObj = results.first {
                    if let students = sectionObj.students  {
                        return students as! [Student]
                    }
                }
            }
        }
        catch {
        }
        return [Student]()
    }
    func getListOfselectionssubject() ->[SelectionModel]{
        let context =  appDelegate.getContext()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Section")
        fetchReq.resultType = .managedObjectResultType
        do {
            let results = try context.fetch(fetchReq)
            print("\(results)")
            return results as! [SelectionModel]
        }
        catch {
            return [SelectionModel]()
        }
    }
    
    
    
    func getUniqueCode() -> String {
        let uuIDStr = UIDevice.current.identifierForVendor?.uuidString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd:MM:YYY:HH:mm:ss"
        let dateStr = dateFormatter.string(from: Date())
        return uuIDStr! + dateStr
    }
    
    
    
    
    
    
    
}
