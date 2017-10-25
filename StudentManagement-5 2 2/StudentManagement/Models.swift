//
//  Models.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 7/21/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class DashBoardModel {
    var todoArray = [TodaysToDosModels]()
    var birthdayArray = [BirthdaysModels]()
    var tommorowBirthdayArray = [BirthdaysModels]()
    var weeklyBirthdayArray = [BirthdaysModels]()
    var todayArray = [ScheduleModel]()
    var tommorrowArray = [ScheduleModel]()
    var weeklyArray = [ScheduleModel]()
    var holidaysArray =  [holidayModel]()
     var eventsArray =  [eventModel]()
    var newsesArray =  [newsModel]()
    
}
class ScheduleModel{
    var periodFrom1:Double?
    var periodFrom = ""
    var periodto1:Double?
    var periodto = ""
    var subjectName = ""
    var gradeId :Int = 0
    var sectionName = ""
    var gradenumber:Int?
    
    class func parseData(dict:Dictionary<String,Any>) -> ScheduleModel {
        let grade = (dict ["gradeid"] as Any)
        let periodFrom1 = (dict["periodfrom"] as? Double)
        let periodFrom = date2(date:periodFrom1!)
        let periodto1 = (dict["periodto"] as? Double)
        let periodto = date2(date:periodto1!)
        let sectionname = (dict["sectionname"])
        let subjectname = (dict["subjectname"])
        let gradenumber = (dict["gradenumber"])
        
        let teacherScheduleObj = ScheduleModel()
        teacherScheduleObj.gradeId = grade as! Int
        teacherScheduleObj.gradenumber = gradenumber as! Int
        teacherScheduleObj.periodFrom = periodFrom as! String
        teacherScheduleObj.periodto = periodto as! String
        teacherScheduleObj.sectionName = sectionname as! String
        teacherScheduleObj.subjectName = subjectname as! String
        //  Models.sharedController().Today = teacherScheduleObj
        
        return teacherScheduleObj
    }

}

class TeacherScheduleTomorrowModels{
    var periodFrom = ""
    var periodto = ""
    var subjectName = ""
    var gradeId = ""
    var sectionName = ""
}

class TodaysToDosModels{
    var description:String = ""
    var actioncode:String?
    var classid:Int?
    var id:Int?
    var notificationdate1:Double?
    var notificationdate:String?
    var notificationname:String?
    var parentactionreqired:Bool?
    var publishedby:String?
    var status:Int?
    class func parseData(dict:Dictionary<String,Any>) -> TodaysToDosModels {
        
        let description = (dict ["description"] as? String)
        let actioncode = (dict["actioncode"] as? String)
        let classid = (dict["classid"] as? Int)
        let id = (dict["id"] as? Int)
        let notificationdate1 = (dict["notificationdate"] as? Double)
        let notificationdate = date1(date:notificationdate1!)
        let notificationname = (dict["notificationname"] as? String)
        let parentactionrequired = (dict["parentactionrequired"] as? Bool)
        let publishedby = (dict["publishedby"] as? String)
        let status = (dict["status"] as? Int)
        
        let  todoModel = TodaysToDosModels()
        todoModel.description = description!
        todoModel.actioncode = actioncode
        todoModel.classid = classid
        todoModel.id = id
        todoModel.notificationdate = notificationdate
        todoModel.notificationname = notificationname
        todoModel.parentactionreqired = parentactionrequired
        todoModel.publishedby = publishedby
        todoModel.status = status
        
        
        return todoModel
    }
}

class  ParentsWallModels{
    var parentsDescription:String = ""
}

class BirthdaysModels{
    var studentName:String = ""
    var studentGrade:Int?
    var studentSection = ""
    var studentDob = ""
    class func parseData(dict:Dictionary<String,Any>) -> BirthdaysModels {
        
        let grade = (dict ["name"] as? String)
        
      let  birthdayModel = BirthdaysModels()
        birthdayModel.studentName = (grade)!
       
        
        return birthdayModel
    }
}



class  StudentModel{
    var admissionnumber:String?
    var fathername:String?
    var id:Int!
    var name:String?
    var isPresent = false
    
    class func parseData(dict:Dictionary<String,Any>) -> StudentModel {
        
        let admissionnumber = (dict ["admissionnumber"] as? String)
        let fathername = (dict["fathername"] as? String)
        let id = (dict["id"] as! Int)
        let name = (dict["name"] as? String)
        
        
        let  StudentModelObj = StudentModel()
        StudentModelObj.admissionnumber =   admissionnumber
        StudentModelObj.fathername = fathername
        StudentModelObj.id = id
        StudentModelObj.name = name
        
        
        return StudentModelObj
}
}

class TeacherMySubject{
    var gradeid:Int = 0
    var id:Int = 0
    var sectionname:String = ""
    var subjectname:String = ""
    var gradenumber:Int = 0
    
    class func parseData(dict:Dictionary<String,Any>) -> TeacherMySubject {
        let grade = dict["gradeid"]! //(dict["gradeid"] as Any)
        let id = dict["id"]!
        let sectionname = (dict["sectionname"] as! String)
        let subjectname = (dict["subjectname"] as? String)
        let gradenumber = dict["gradenumber"]!
        
        let  teacherMysubobj = TeacherMySubject()
        teacherMysubobj.gradenumber = gradenumber as! Int
        teacherMysubobj.gradeid = grade as! Int
        teacherMysubobj.id = id as! Int
        teacherMysubobj.sectionname = sectionname
        if(subjectname == nil){
            teacherMysubobj.subjectname = "Class Teacher"
        }
        else{
        teacherMysubobj.subjectname = subjectname!
        }
        return teacherMysubobj
    }

}


class ChildMySubject{
    var classid:Int = 0
    var classteacherid:Int = 0
    var gradeid:Int = 0
    var gradename:String = ""
    var name:String = ""
    var id:Int = 0
    var sectionname:String = ""
    var studentid:Int = 0
    var syllabustype:String = ""
    var teachername:String = ""
    
    
    class func parseData(dict:Dictionary<String,Any>) -> ChildMySubject {
        let classid = dict["classid"]!
        let gradeid = dict["gradeid"]! //(dict["gradeid"] as Any)
        let classteacherid = dict["classteacherid"]!
        let id = dict["id"]
        let studentid = dict["studentid"]
        let gradename = (dict["gradename"] as! String)
        let sectionname = (dict["sectionname"] as! String)
        let name = (dict["name"] as? String)
        let teachername = (dict["teachername"] as! String)
        let syllabustype = (dict["syllabustype"] as? String)

       
        
        let  childObj = ChildMySubject()
        childObj.classid = classid as! Int
        childObj.gradeid = gradeid as! Int
        childObj.id = id as! Int
        childObj.classteacherid = classteacherid as! Int
        childObj.studentid = studentid as! Int
        childObj.gradename = gradename
        childObj.sectionname = sectionname
        childObj.name = name!
        childObj.teachername = teachername
        childObj.syllabustype = syllabustype!
        
        
        return childObj
    }
    
}


class  TeacherProfileModel{
    var about:String?
    var  address:String?
    var contactnumber:String?
    var dateofbirth1:Double?
    var dateofbirth:String?
    var dateofjoining1:Double?
    var dateofjoining:String?
    var emailid:String?
    var gender:String?
    var id:Int?
    var lname:String?
    var noofperiods:Int?
    var qualification:String?
    var subjects:String?
    var teachername:String?
    
    class func parseData(dict:Dictionary<String,Any>) -> TeacherProfileModel {
        let about = (dict["about"] as! String) //(dict["gradeid"] as Any)
        let address = (dict["address"] as! String)
        let contactnumber = (dict["contactnumber"] as! String)
        let dateofbirth1 = (dict["dateofbirth"] as! Double)
        let dateofbirth = date1(date:dateofbirth1)
        let dateofjoining1 = (dict["dateofjoining"] as? Double)
        let dateofjoining = date1(date:dateofjoining1!)
        let id = (dict["id"] as! Int)
        let lname = (dict["lname"] as! String)
        let noofperiods = dict["noofperiods"]
        let qualification = (dict["qualification"] as! String)
        let subjects = (dict["subjects"] as! String)
       let teachername = (dict["teachername"] as! String)
        let emailid = (dict["emailid"] as! String)
        let gender = (dict["gender"] as! String)
        
       let  teacherProfileObj = TeacherProfileModel()
        teacherProfileObj.about = about
        teacherProfileObj.address = address
        teacherProfileObj.contactnumber = contactnumber
        teacherProfileObj.dateofbirth = dateofbirth
        teacherProfileObj.dateofjoining = dateofjoining
        teacherProfileObj.emailid = emailid
        teacherProfileObj.id = id
        teacherProfileObj.gender = gender
        teacherProfileObj.subjects = subjects
        teacherProfileObj.lname = lname
        teacherProfileObj.teachername = teachername
        teacherProfileObj.qualification = qualification
        teacherProfileObj.noofperiods = noofperiods as! Int? 
        
        
        
        
        return teacherProfileObj
    }

    
}
class LoginResponseModel{
    var description:String?
    var status:Int?
    var userid:Int?
    var username:String?
    var userrole:String?
    
    class func parseData (dict:Dictionary<String,Any>) -> LoginResponseModel{
    let description = (dict["description"] as? String)
    let status = (dict["status"] as? Int)
    let userid = (dict["userid"]as? Int)
    let username = (dict["username"] as? String)
    let userrole = (dict["userrole"]as? String)
    
    let loginObj = LoginResponseModel()
    loginObj.description = description
        loginObj.status = status
        loginObj.userid = userid
        loginObj.username = username
        loginObj.userrole = userrole
        return loginObj
    
}
}
class newsModel{
    var description:String?
    var headline:String?
    var id:Int?
    var releasedate1:Double?
    var releasedate:String?
    
    class func parseData(dict:Dictionary<String,Any>) -> newsModel {
        let description = (dict["description"] as! String) //(dict["gradeid"] as Any)
        let headline = (dict["headline"] as! String)
        let releasedate1 = (dict["releasedate"] as?Double)
        let releasedate = date1(date:releasedate1!)
      //  let releasedate = (dict["releasedate"] as! String)
        let id = (dict["id"] as! Int)
        
        let  newsObj = newsModel()
        newsObj.description = description
        newsObj.headline = headline
        newsObj.id = id
        newsObj.releasedate = releasedate
        
        return newsObj
       }
}

class holidayModel{
    var fromdate1:Double?
    var fromdate:String?
    var occassion:String?
    var id:Int?
    var todate1:Double?
    var todate:String?
    
    class func parseData(dict:Dictionary<String,Any>) -> holidayModel {
        let fromdate1 = (dict["fromdate"] as! Double)
        let fromdate = date1(date: fromdate1)
        let occassion = (dict["occassion"] as! String)
        let todate1 = (dict["todate"] as! Double)
        let todate = date1(date: todate1)
        let id = (dict["id"] as! Int)
        
        let  holidayObj = holidayModel()
        holidayObj.fromdate = fromdate
        holidayObj.occassion = occassion
        holidayObj.id = id
        holidayObj.todate = todate
        
        return holidayObj
    }
}


class eventModel{
    var chiefguest:String?
    var description:String?
    var id:Int?
    var eventdate1:Double?
    var eventdate:String?
    var eventname:String?
    
    class func parseData(dict:Dictionary<String,Any>) -> eventModel {
        let description = (dict["description"] as! String) //(dict["gradeid"] as Any)
        let chiefguest = (dict["chiefguest"] as! String)
        let eventdate1 = (dict["eventdate"] as! Double)
        let eventdate = date1(date: eventdate1)
        let id = (dict["id"] as! Int)
        let eventname = (dict["eventname"] as! String)
        
        let  eventObj = eventModel()
        eventObj.description = description
        eventObj.chiefguest = chiefguest
        eventObj.id = id
        eventObj.eventdate = eventdate
        eventObj.eventname = eventname
        
        return eventObj
    }
}

class studentAttendanceModel{
    var attendancestatus:Int?
    var day:Int?
    var id:Int?
    var dateofattendance1:Double?
    var dateofattendance:String?
    var showdate:String?
    var subjectattendance:String?
    var subjectname:String?
    
    class func parseData(dict:Dictionary<String,Any>) -> studentAttendanceModel {
        let attendancestatus = (dict["attendancestatus"] as! Int) //(dict["gradeid"] as Any)
        let day = (dict["day"] as! Int)
        let dateofattendance1 = (dict["dateofattendance"] as! Double)
        let dateofattendance = date1(date: dateofattendance1)
        let id = (dict["id"] as! Int)
        let showdate = (dict["showdate"] as? String)
        let subjectattendace = (dict["subjectattendance"] as? String)
        let subjectname = (dict["subjectname"] as? String)
        
        let  studentattendanceObj = studentAttendanceModel()
        studentattendanceObj.attendancestatus = attendancestatus
        studentattendanceObj.day = day
        studentattendanceObj.id = id
        studentattendanceObj.dateofattendance = dateofattendance
        studentattendanceObj.showdate = showdate
        studentattendanceObj.subjectattendance = subjectattendace
        studentattendanceObj.subjectname = subjectname
        
        return studentattendanceObj
    }
}

class AlertModel:NSObject {
    var title:String = ""
    var idStr:String = ""
    var otherInfo:Any?
    
    init(title:String) {
        self.title = title
    }
    
    init(title:String,idStr:String) {
        self.title = title
        self.idStr = idStr
    }
    
    init(title:String,idStr:String,otherInfo:Any) {
        self.title = title
        self.idStr = idStr
        self.otherInfo = otherInfo
    }
}
class TimeLineModel {
    var assignmentduedate:String?
    var assignmentduedate1:Double?
    var assignmentname:String?
    var id:Int?
    var lessonname:String!
    var lessonstartdate1:Double?
    var lessonstartdate:String?
    var lessondescription:String?
    var publish:String?
    var publishtimeline:Int?
    var status:String?
    var subjectname:String?
    var tags:String?
    var worksheetduedate1:Double?
    var worksheetduedate:String?
    var worksheetname:String?
    var assignments:String?
    var worksheets:String?
    var assignmentArray = [TimelineAssignModel]()
    var wsArray = [TimelineWSModel]()
    
    
    class func parseData(dict:Dictionary<String,Any>) -> TimeLineModel {
        let  timelineObj = TimeLineModel()
        if let assignmentduedate1 = (dict["assignmentduedate"] as? Double){
            let assignmentduedate = date1(date:(assignmentduedate1))
            timelineObj.assignmentduedate = assignmentduedate
        }
        let assignmentname = (dict["assignmentname"] as? String)//(dict["gradeid"] as Any)
        let id = (dict["id"] as! Int)
        let lessonname = (dict["lessonname"] as? String)
        if  let lessonstartdate1 = (dict["lessonstartdate"] as? Double){
        let lessonstartdate = date1(date: lessonstartdate1)
            timelineObj.lessonstartdate = lessonstartdate
        }
        let status = (dict["status"] as? String)
        let subjectname = (dict["subjectname"] as? String)
        let lessondescription = (dict["lessondescription"] as? String)
        let publish = (dict["publish"] as? String)
        let publishtimeline = (dict["publishtimeline"] as? Int)
        let tags = (dict["tags"] as? String)
        if let worksheetduedate1 = (dict["worksheetduedate"] as? Double){
            let worksheetduedate = date1(date:worksheetduedate1)
            timelineObj.worksheetduedate = worksheetduedate
        }
        let worksheetname = (dict["worksheetname"] as? String)
        let assignments = (dict["assignment"] as? String)
        let  worksheets = (dict["worksheets"] as? String)
        
        timelineObj.assignmentname = assignmentname
        timelineObj.id = id
        timelineObj.lessondescription = lessondescription
        timelineObj.publish = publish
        timelineObj.publishtimeline = publishtimeline
        timelineObj.lessonname = lessonname
      timelineObj.status = status 
        timelineObj.subjectname = subjectname
        timelineObj.tags = tags
        timelineObj.worksheetname = worksheetname
        timelineObj.worksheets = worksheets
        timelineObj.assignments = assignments
        let assignmentArray:Array? = (dict["assignments"] as? Array<[String:Any]>)
        
        if((assignmentArray) != nil){
            for assigndict in assignmentArray!{
                timelineObj.assignmentArray.append(TimelineAssignModel.parseData(assigndict:assigndict))
            }
        }
         let wsArray:Array? = (dict["worksheets"] as? Array<[String:Any]>)
        if((wsArray) != nil){
            for assigndict in wsArray!{
                timelineObj.wsArray.append(TimelineWSModel.parseData(assigndict:assigndict))
            }
        }
        
       
        return timelineObj
}
}
class TimelineAssignModel
{
    var lessonname:String?
    var assignmentname:String?
    var dateofassigned1:Double?
    var dateofassigned:String?
    var duedate:String?
    var assignmentduedate1:Double?
    var assignmentduedate:String?
    var tags:String?
    var publishassignment:Bool?
    var subjectname:String?
    var id:Int!
    var assignedid:Int?
    
    class  func parseData(assigndict:Dictionary<String,Any> ) -> TimelineAssignModel{
        let  timeAssignedObj = TimelineAssignModel()
        let lessonname = (assigndict["lessonname"] as? String)
        let assignmentname = (assigndict["assignmentname"] as? String)
        if let dateofassigned1 = (assigndict["dateofassigned"] as? Double){
            let dateofassigned = date1(date: dateofassigned1)
            timeAssignedObj.dateofassigned = dateofassigned
        }
        let duedate = (assigndict["duedate"] as? String)
        if   let assignmentduedate1 = (assigndict["assignmentduedate"] as? Double){
        let assignmentduedate = date1(date: assignmentduedate1)
            timeAssignedObj.assignmentduedate = assignmentduedate
        }
        let tags = (assigndict["tags"] as? String)
        let publishassignment = (assigndict["publishassignment"] as? Bool)
        let subjectname = (assigndict["subjectname"] as? String)
        let id = (assigndict["id"] as? Int)
        let assignedid = (assigndict["assignedid"] as? Int)
        
       
        timeAssignedObj.lessonname = lessonname
        timeAssignedObj.assignmentname = assignmentname
       // timeAssignedObj.dateofassigned = dateofassigned
        timeAssignedObj.duedate = duedate
        
        timeAssignedObj.tags = tags
        timeAssignedObj.publishassignment = publishassignment
        timeAssignedObj.subjectname = subjectname
        timeAssignedObj.id = id
        timeAssignedObj.assignedid = assignedid
        return timeAssignedObj
        
    }
}

class TimelineWSModel
{
    var createdby:String?
    var degreeofdifficulty:String?
    var dateofassigned1:Double?
    var dateofassigned:String?
    var description:String?
    var duedate:String?
    var gradeid:Int?
    var id:Int!
    var lessonname:String?
    var publishworksheet:Bool?
    var subjectname:String?
    var tag:String?
    var worksheet:String?
    var worksheetduedate1:Double?
    var worksheetduedate:String?
    var worksheetid:Int!
    var worksheetname:String?
    var worksheetpath:String?
    
    class  func parseData(assigndict:Dictionary<String,Any>) -> TimelineWSModel{
        let  timelineWSObj = TimelineWSModel()
        let createdby = (assigndict["createdby"] as? String)
        let degreeofdifficulty = (assigndict["degreeofdifficulty"] as? String)
        if let dateofassigned1 = (assigndict["dateofassigned"] as? Double){
            let dateofassigned = date1(date: dateofassigned1)
            timelineWSObj.dateofassigned = dateofassigned
        }
        let duedate = (assigndict["duedate"] as? String)
        let description = (assigndict["description"] as? String)
        let lessonname = (assigndict["lessonname"] as? String)
        let publishworksheet = (assigndict["publishworksheet"] as? Bool)
        let subjectname = (assigndict["subjectname"] as? String)
        let id = (assigndict["id"] as? Int)
        let gradeid = (assigndict["gradeid"] as? Int)
        let tag = (assigndict["tag"] as? String)
        let worksheet = (assigndict["worksheet"] as? String)
        if let worksheetduedate1 = (assigndict["worksheetduedate"] as? Double){
            let worksheetduedate = date1(date: worksheetduedate1)
            timelineWSObj.worksheetduedate = worksheetduedate
        }
        let worksheetduedate = (assigndict["worksheetduedate"] as? String)
        let worksheetid = (assigndict["worksheetid"] as? Int)
        let worksheetname = (assigndict["worksheetname"] as? String)
        let worksheetpath = (assigndict["worksheetpath"] as? String)
        
       timelineWSObj.createdby = createdby
        timelineWSObj.degreeofdifficulty = degreeofdifficulty
       timelineWSObj.duedate = duedate
        timelineWSObj.description = description
        timelineWSObj.lessonname = lessonname
        timelineWSObj.publishworksheet = publishworksheet
        timelineWSObj.subjectname = subjectname
        timelineWSObj.id = id
        timelineWSObj.gradeid = gradeid
        timelineWSObj.tag = tag
        timelineWSObj.worksheet = worksheet
        
        timelineWSObj.worksheetid = worksheetid
        timelineWSObj.worksheetname = worksheetname
        timelineWSObj.worksheetpath = worksheetpath
        return timelineWSObj
                
    }
}

    class AssignedworksheetslistModel{
        var worksheetname:String?
        var degreeofdifficulty:String?
        var id:Int?
        var gradeid:Int?
        var subjectname:String?
        var tags:String?
        var description:String?
        var worksheetpath:String?
        var worksheet:String?
        var createdby:String?
        var dateofassigned1:Double?
        var dateofassigned:String?
        var duedate:String?
        var worksheetduedate:String?
        var publishworksheet:Bool?
        var lessonname:String?
        var worksheetid:Int?
        
        class func parseData(dict:Dictionary<String,Any>) -> AssignedworksheetslistModel {
            let  assignedworksheetObj = AssignedworksheetslistModel()
            let worksheetname = (dict["worksheetname"] as? String)
            let degreeofdifficulty = (dict["degreeofdifficulty"] as? String)//(dict["gradeid"] as Any)
            let id = (dict["id"] as! Int)
            let gradeid = (dict["gradeid"] as? Int)
            let subjectname = (dict["subjectname"] as? String)
            let tags = (dict["tags"] as? String)
            let description = (dict["description"] as? String)
            let worksheetpath = (dict["worksheetpath"] as? String)
            let worksheet = (dict["worksheet"] as? String)
            let createdby = (dict["createdby"] as? String)
            if let dateofassigned1 = (dict["dateofassigned"] as? Double){
                let dateofassigned = date1(date: dateofassigned1)
                assignedworksheetObj.dateofassigned = dateofassigned
            }
            let duedate = (dict["duedate"] as? String)
            let worksheetduedate = (dict["worksheetduedate"] as? String)
            let  lessonname = (dict["lessonname"] as? String)
            let worksheetid = (dict["worksheetid"] as? Int)
            let publishworksheet = (dict["publishworksheet"] as? Bool)

            
            assignedworksheetObj.worksheetname = worksheetname
            assignedworksheetObj.degreeofdifficulty = degreeofdifficulty
            assignedworksheetObj.id = id
            assignedworksheetObj.gradeid = gradeid
            assignedworksheetObj.subjectname = subjectname
            assignedworksheetObj.tags = tags
            assignedworksheetObj.description = description
            assignedworksheetObj.worksheetpath = worksheetpath
            assignedworksheetObj.worksheet = worksheet
            assignedworksheetObj.createdby = createdby
            assignedworksheetObj.worksheetpath = worksheetpath
            assignedworksheetObj.duedate = duedate
            assignedworksheetObj.lessonname = lessonname
            assignedworksheetObj.worksheetid = worksheetid
            assignedworksheetObj.publishworksheet = publishworksheet
           assignedworksheetObj.worksheetduedate = worksheetduedate
            
            return assignedworksheetObj
    }

}


class ListofworksheetslistModel{
    var worksheetname:String!
    var degreeofdifficulty:String?
    var id:Int?
    var gradeid:Int?
    var subjectname:String?
    var tags:String?
    var description:String?
    var worksheetpath:String?
    var worksheet:String?
    var createdby:String?
    var dateofassigned:String?
    var duedate:String?
    var worksheetduedate:String?
    var publishworksheet:Bool?
    var lessonname:String?
    var worksheetid:Int?
    
    class func parseData(dict:Dictionary<String,Any>) -> ListofworksheetslistModel {
        let worksheetname = (dict["worksheetname"] as! String)
        let degreeofdifficulty = (dict["degreeofdifficulty"] as? String)//(dict["gradeid"] as Any)
        let id = (dict["id"] as? Int)
        let gradeid = (dict["gradeid"] as? Int)
        let subjectname = (dict["subjectname"] as! String)
        let tags = (dict["tags"] as? String)
        let description = (dict["description"] as? String)
        let worksheetpath = (dict["worksheetpath"] as? String)
        let worksheet = (dict["worksheet"] as? String)
        let createdby = (dict["createdby"] as? String)
        let  dateofassigned = (dict["dateofassigned"] as? String)
        let duedate = (dict["duedate"] as? String)
        let worksheetduedate = (dict["worksheetduedate"] as? String)
        let  lessonname = (dict["lessonname"] as? String)
        let worksheetid = (dict["worksheetid"] as? Int)
        let publishworksheet = (dict["publishworksheet"] as? Bool)
        
        let  assignedworksheetObj = ListofworksheetslistModel()
        assignedworksheetObj.worksheetname = worksheetname
        assignedworksheetObj.degreeofdifficulty = degreeofdifficulty
        assignedworksheetObj.id = id
        assignedworksheetObj.gradeid = gradeid
        assignedworksheetObj.subjectname = subjectname
        assignedworksheetObj.tags = tags
        assignedworksheetObj.description = description
        assignedworksheetObj.worksheetpath = worksheetpath
        assignedworksheetObj.worksheet = worksheet
        assignedworksheetObj.createdby = createdby
        assignedworksheetObj.dateofassigned = dateofassigned
        assignedworksheetObj.worksheetpath = worksheetpath
        assignedworksheetObj.duedate = duedate
        assignedworksheetObj.lessonname = lessonname
        assignedworksheetObj.worksheetid = worksheetid
        assignedworksheetObj.publishworksheet = publishworksheet
        
        return assignedworksheetObj
    }
    
}

    class AssignedAssignmentModel {
        var lessonname:String?
        var assignmentname:String?
        var id:Int?
        var dateofassigned1:Double?
        var dateofassigned:String?
        var duedate:String?
        var assignmentduedate:String?
        var tags:String?
        var publishassignment:String?
        var subjectname:String?
        var assignedid:Int?
        
        
        class func parseData(dict:Dictionary<String,Any>) -> AssignedAssignmentModel {
            let  assignedassignmentObj = AssignedAssignmentModel()
            
            let lessonname = (dict["lessonname"] as? String)
            let assignmentname = (dict["assignmentname"] as? String)//(dict["gradeid"] as Any)
            let id = (dict["id"] as! Int)
            if let dateofassigned1 = (dict["dateofassigned"] as? Double){
                let dateofassigned = date1(date: dateofassigned1)
                assignedassignmentObj.dateofassigned = dateofassigned
            }
            let duedate = (dict["duedate"] as? String)
            if   let assignmentduedate1 = (dict["assignmentduedate"] as? Double){
                let assignmentduedate = date1(date: assignmentduedate1)
                assignedassignmentObj.assignmentduedate = assignmentduedate
            }
            let tags = (dict["tags"] as? String)
            let publishassignment = (dict["publishassignment"] as? String)
            let subjectname = (dict["subjectname"] as? String)
            let assignedid = (dict["assignedid"] as? Int)
           
            
            
            assignedassignmentObj.lessonname = lessonname
            assignedassignmentObj.assignmentname = assignmentname
            assignedassignmentObj.id = id
          //  assignedassignmentObj.dateofassigned = dateofassigned
            assignedassignmentObj.duedate = duedate
            assignedassignmentObj.tags = tags
            assignedassignmentObj.publishassignment = publishassignment
            assignedassignmentObj.subjectname = subjectname
            assignedassignmentObj.assignedid = assignedid
            
            
            
            
            return assignedassignmentObj
        }
    }

class TestListModel {
    var academicyear:String?
    var startdate1:Double?
    var startdate:String?
    var id:Int?
    var enddate1:Double?
    var enddate:String?
    var maxmarks:Int!
    var subjectid:Int?
   // var subjects:String?
    var status:String?
    var syllabus:String?
    var testid:Int!
    var testmode:String?
    var testtype:String?
    var subjectsArray = [SubjectsTestModel]()
    
    class func parseData(dict:Dictionary<String,Any>) -> TestListModel {
        let academicyear = (dict["academicyear"] as? String)
        let enddate1 = (dict["enddate"] as? Double)
        let  enddate = date1(date:enddate1!)
        let id = (dict["id"] as! Int)
        let maxmarks = (dict["maxmarks"] as? Int)
        let startdate1 = (dict["startdate"] as! Double)
        let startdate = date1(date: startdate1)
        let subjectid = (dict["subjectid"] as? Int)
     //   let subjects = (dict["subjects"] as? String)
        let syllabus = (dict["syllabus"] as? String)
        let testid = (dict["testid"] as? Int)
        let testmode = (dict["testmode"] as? String)
        let  testtype = (dict["testtype"] as? String)
        let status = (dict["status"] as? String)
        
        let  testlistObj = TestListModel()
        testlistObj.status = status
        testlistObj.academicyear = academicyear
        testlistObj.enddate = enddate
        testlistObj.id = id
        testlistObj.maxmarks = maxmarks
        testlistObj.startdate = startdate
        testlistObj.subjectid = subjectid
      //  testlistObj.subjects = subjects
        testlistObj.syllabus = syllabus
        testlistObj.testid = testid
        testlistObj.testmode = testmode
        testlistObj.testtype = testtype
        let subjectsArray:Array? = (dict["subjects"] as? Array<[String:Any]>)

        if((subjectsArray) != nil){
            for dict in subjectsArray!{
                testlistObj.subjectsArray.append(SubjectsTestModel.parseData(dict:dict))
            }
            
        }else{
//            let  testlistObj = TestListModel()
//            let subjects = (dict["subjects"] as? String)
//            testlistObj.subjects = subjects
            
        }
       
       return testlistObj
    }
}
class SubjectsTestModel{
    var id:Int?
    var marks:Int?
    var maxmarks:Int!
    var subjectid:Int?
    var subjectname:String?
    var syllabus:String?
    var testid:Int?
    class func parseData(dict:Dictionary<String,Any>) -> SubjectsTestModel{
        let subjectname = (dict["subjectname"] as? String)
        let id = (dict["id"] as? Int)
         let marks = (dict["marks"] as? Int)
         let maxmarks = (dict["maxmarks"] as? Int)
         let subjectid = (dict["subjectid"] as? Int)
         let syllabus = (dict["syllabus"] as? String)
        let testid = (dict["testid"] as? Int)
        
        
        var subObj = SubjectsTestModel()
        subObj.subjectname = subjectname
        subObj.id = id
        subObj.marks = marks
        subObj.maxmarks = maxmarks
        subObj.subjectid = subjectid
        subObj.syllabus = syllabus
        subObj.testid = testid
        return subObj
    }

}

class  ViewReultsModel
{
    var resultstransferArray = [ResulttransferModel]()
    var subjectsArray = [SubjectsModel]()
    
    class func parseData(dict:Dictionary<String,Any>) -> ViewReultsModel{
        var viewObj = ViewReultsModel()
       let subjectsArray:Array? = (dict["subjects"] as? Array<[String:Any]>)
        let resultstransferArray:Array? = (dict["resulttransfer"] as? Array<[String:Any]>)
        if((resultstransferArray) != nil){
            for dict in resultstransferArray!{
                viewObj.resultstransferArray.append(ResulttransferModel.parseData(dict:dict))
            }
        }
        if((subjectsArray) != nil){
            for dict in subjectsArray!{
                viewObj.subjectsArray.append(SubjectsModel.parseData(dict:dict))
            }
        }
        return viewObj
    }
}
class ResulttransferModel{
    var name:String?
    var studentid:Int?
    var testtype:String?
     var studentsubjectmarksArray = [StudentSubjectMarksModel]()
    
     class func parseData(dict:Dictionary<String,Any>) -> ResulttransferModel{
        
        let name = (dict["name"] as? String)
        let studentid = (dict["studentid"] as? Int)
        let testtype = (dict["testtype"] as? String)
        var transferObj = ResulttransferModel()
        transferObj.name = name
        transferObj.studentid = studentid
        transferObj.testtype = testtype
        let studentsubjectmarksArray:Array? = (dict["studentsubjectmarks"] as? Array<[String:Any]>)
        if((studentsubjectmarksArray) != nil){
            for dict in studentsubjectmarksArray!{
                transferObj.studentsubjectmarksArray.append(StudentSubjectMarksModel.parseData(dict:dict))
            }
        }
   return transferObj
    }
}
class StudentSubjectMarksModel{
    var marks:Int?
    var subjectname:String?
    
    class func parseData(dict:Dictionary<String,Any>) -> StudentSubjectMarksModel{
        let marks = (dict["marks"] as? Int)
        let sujectname = (dict["subjectname"] as? String)
        var stusubObj = StudentSubjectMarksModel()
        stusubObj.marks = marks
        stusubObj.subjectname = sujectname
        return stusubObj
 }
}
class SubjectsModel{
    var subjectname:String?
    class func parseData(dict:Dictionary<String,Any>) -> SubjectsModel{
    let subjectname = (dict["subjectname"] as? String)
         var subObj = SubjectsModel()
        subObj.subjectname = subjectname
        return subObj
    }
}

class MessagesModel{
    var classroomid:Int?
    var dateofmessage:String?
    var id:Int?
    var message:String?
   // var messagedate:String?
    var mothername:String?
    var name:String?
    var parentmessageid:Int?
    var recieverid:Int?
    var rootmessageid:Int?
    var senderid:Int?
    var sendername:String?
    var sentflag:String?
    var teachername:String?
    var recievername:String?
    var replymessagesArray = [MessagesModel]()
    
    class func parseData(dict:Dictionary<String,Any>) -> MessagesModel {
        let classroomid = (dict["classroomid"] as? Int)
        let dateofmessage = (dict["dateofmessage"] as? String)//(dict["gradeid"] as Any)
        let id = (dict["id"] as! Int)
        let message = (dict["message"] as? String)
      //  let messagedate = (dict["messagedate"] as! String)
        let mothername = (dict["mothername"] as? String)
        let parentmessageid = (dict["parentmessageid"] as? Int)
        let name = (dict["name"] as? String)
        let recieverid = (dict["recieverid"] as? Int)
        let sendername = (dict["sendername"] as? String)
        let recivername = (dict["recivername"] as? String)
        let sentflag = (dict["sentflag"] as? String)
        let teachername = (dict["teachername"] as? String)
        let rootmessageid = (dict["rootmessageid"] as? Int)
        let senderid = (dict["senderid"] as? Int)
        
        
        
        
        let  messObj = MessagesModel()
        messObj.classroomid = classroomid
        messObj.dateofmessage = dateofmessage
        messObj.id = id
        messObj.message = message
        messObj.recievername = recivername
      //  messObj.messagedate = messagedate
        messObj.mothername = mothername
        messObj.parentmessageid = parentmessageid
        messObj.name = name
        messObj.recieverid = recieverid
        messObj.sendername = sendername
        messObj.sentflag = sentflag
        messObj.teachername = teachername
        messObj.rootmessageid = rootmessageid
        messObj.senderid = senderid
        
        let replayMessagesArray:Array? = (dict["replymessages"] as? Array<[String:Any]>)

        if((replayMessagesArray) != nil){
             for replydict in replayMessagesArray!{
               messObj.replymessagesArray.append( parseData(dict: replydict))
            }
        }
 

        
        
        return messObj
    }
    
    
       class  func addReplayMessage(replydict:Dictionary<String,Any> , _ mainMessage:MessagesModel!) -> Void{
        
                let classroomid = (replydict["classroomid"] as? Int)
                let dateofmessage = (replydict["dateofmessage"] as? String)//(dict["gradeid"] as Any)
                let id = (replydict["id"] as! Int)
                let message = (replydict["message"] as? String)
                //  let messagedate = (dict["messagedate"] as! String)
                let mothername = (replydict["mothername"] as? String)
                let parentmessageid = (replydict["parentmessageid"] as? Int)
                let name = (replydict["name"] as? String)
                let recieverid = (replydict["recieverid"] as? Int)
                let sendername = (replydict["sendername"] as? String)
                let sentflag = (replydict["sentflag"] as? String)
                let teachername = (replydict["teachername"] as? String)
                let rootmessageid = (replydict["rootmessageid"] as? Int)
                let senderid = (replydict["senderid"] as? Int)
        
        let  messObj = MessagesModel()
        messObj.classroomid = classroomid
        messObj.dateofmessage = dateofmessage
        messObj.id = id
        messObj.message = message
        //  messObj.messagedate = messagedate
        messObj.mothername = mothername
        messObj.parentmessageid = parentmessageid
        messObj.name = name
        messObj.recieverid = recieverid
        messObj.sendername = sendername
        messObj.sentflag = sentflag
        messObj.teachername = teachername
        messObj.rootmessageid = rootmessageid
        messObj.senderid = senderid

                
        
     }

}



class AddAssignmentModel {
    var classroomid:Int?
    var lessondescription:String?
    var id:Int?
    var lessonname:String?
    var lessonstartdate:String?
    var status:String?
    var subjectid:Int?
   
    
    class func parseData(dict:Dictionary<String,Any>) -> AddAssignmentModel {
        let classroomid = (dict["classroomid"] as? Int)
        let lessondescription = (dict["lessondescription"] as? String)//(dict["gradeid"] as Any)
        let id = (dict["id"] as! Int)
        let lessonname = (dict["lessonname"] as! String)
        let lessonstartdate = (dict["lessonstartdate"] as! String)
        let status = (dict["status"] as? String)
        let subjectid = (dict["subjectid"] as? Int)
        
        let  timelineObj = AddAssignmentModel()
        timelineObj.classroomid = classroomid
        timelineObj.lessondescription = lessondescription
        timelineObj.id = id
        timelineObj.lessonname = lessonname
        timelineObj.lessonstartdate = lessonstartdate
        timelineObj.status = status
        timelineObj.subjectid = subjectid
       
        
        
        return timelineObj
    }
    
}

class SendMessageModel {
    var admissionnumber:String?
    var fathername:String?
    var id:Int?
    var name:String!
    var parentid:Int!
    var status:String?
    var isSelected = false
    
    
    
    class func parseData(dict:Dictionary<String,Any>) -> SendMessageModel {
        let admissionnumber = (dict["admissionnumber"] as? String)
        let fathername = (dict["fathername"] as? String)//(dict["gradeid"] as Any)
        let id = (dict["id"] as! Int)
        let name = (dict["name"] as! String)
       // let parentid = (dict["parentid"] as? NSNumber)?.stringValue
        let parentid = (dict["parentid"] as? Int)
        let status = (dict["status"] as? String)
        
        let  sendmessObj = SendMessageModel()
        sendmessObj.admissionnumber = admissionnumber
        sendmessObj.fathername = fathername
        sendmessObj.id = id
        sendmessObj.name = name
        sendmessObj.parentid = parentid
        sendmessObj.status = status
       
        
        
        
        return sendmessObj
    }
    
}


class  enterMarksModel{
    var id:Int!
    var academicyear:String?
    var syllabustype:String?
    var gradename:String?
    var sectionname:String?
    var testtype:String?
    var marks:Int?
    var testmode:String?
    var classid:Int?
    var subjectname:String?
    var name:String?
    var admissionnumber:Int?
    var gradeid:Int?
    var subjectid:Int!
    var startdate:String?
    var resultorgrade:String?
    var testid:Int!
    var studentid:Int?
    var maxmarks:Int!
    var studentsubjectmarks:Int?
    var enteredMarks:String?
    
    
    class func parseData(dict:Dictionary<String,Any>) -> enterMarksModel {
        let classid = (dict["classid"] as? Int)
        let academicyear = (dict["academicyear"] as? String)//(dict["gradeid"] as Any)
        let id = (dict["id"] as? Int)
        let syllabustype = (dict["syllabustype"] as? String)
        let gradename = (dict["gradename"] as? String)
        let sectionname = (dict["sectionname"] as? String)
        let marks = (dict["marks"] as? Int)
        let testtype = (dict["testtype"] as? String)
        let subjectname = (dict["subjectname"] as? String)
        let testmode = (dict["testmode"] as? String)
        let name = (dict["name"] as? String)
        let studentsubjectmarks = (dict["studentsubjectmarks"] as? Int)
        let maxmarks = (dict["maxmarks"] as? Int)
        let studentid = (dict["studentid"] as? Int)
        let testid = (dict["testid"] as! Int)
        let resultorgrade = (dict["resultorgrade"] as? String)
        let startdate = (dict["startdate"] as? String)
        let subjectid = (dict["subjectid"] as? Int)
        let gradeid = (dict["gradeid"] as? Int)
        let admissionnumber = (dict["admissionnumber"] as? Int)
      //  let enteredMarks = (dict["enteredMarks"] as? String)
        
        
        let  entermarksObj = enterMarksModel()
      //  entermarksObj.enteredMarks = enteredMarks
        entermarksObj.classid = classid
        entermarksObj.academicyear = academicyear
        entermarksObj.id = id
        entermarksObj.syllabustype = syllabustype
        entermarksObj.gradename = gradename
        entermarksObj.sectionname = sectionname
        entermarksObj.marks = marks
        entermarksObj.testtype = testtype
        entermarksObj.subjectname = subjectname
        entermarksObj.testid = testid
        entermarksObj.testmode = testmode
        entermarksObj.name = name
        entermarksObj.studentsubjectmarks = studentsubjectmarks
        entermarksObj.maxmarks = maxmarks
        entermarksObj.studentid = studentid
        entermarksObj.resultorgrade = resultorgrade
        entermarksObj.startdate = startdate
        entermarksObj.subjectid = subjectid
        entermarksObj.gradeid = gradeid
        entermarksObj.admissionnumber = admissionnumber
        
        
        
        return entermarksObj
        
    }
    
}

class  replyMessagesModel{
    var classroomid:Int?
    var dateofmessage:String?
    var fathername:String?
    var id:Int?
    var message:String?
    var messagedate:String?
    var mothername:String?
    var name:String?
    var parentmessageid:Int?
    var recieverid:Int?

    
    class func parseData(dict:Dictionary<String,Any>) -> replyMessagesModel {
        let classroomid = (dict["classroomid"] as? Int)
        let dateofmessage = (dict["dateofmessage"] as? String)//(dict["gradeid"] as Any)
        let id = (dict["id"] as! Int)
        let message = (dict["message"] as! String)
        let messagedate = (dict["messagedate"] as! String)
        let mothername = (dict["mothername"] as? String)
        let parentmessageid = (dict["parentmessageid"] as? Int)
        let name = (dict["name"] as! String)
        let recieverid = (dict["recieverid"] as? Int)
        
        let  messObj = replyMessagesModel()
        messObj.classroomid = classroomid
        messObj.dateofmessage = dateofmessage
        messObj.id = id
        messObj.message = message
        messObj.messagedate = messagedate
        messObj.mothername = mothername
        messObj.parentmessageid = parentmessageid
        
        
        
        return messObj

}
    
}

func date1(date: Double) -> String{
    let epocTime = TimeInterval( date) / 1000
    
    let myDate = Date(timeIntervalSince1970:  epocTime)
    let dateFormatter2 = DateFormatter()
    dateFormatter2.timeStyle = DateFormatter.Style.medium //Set time style
    dateFormatter2.dateStyle = DateFormatter.Style.medium //Set date style
    dateFormatter2.dateFormat = "dd-MM-YYYY";
    dateFormatter2.timeZone = TimeZone.current
    let localDate = dateFormatter2.string(from: myDate as Date)
    return localDate
}
func date2(date: Double) -> String{
    let epocTime = TimeInterval( date) / 1000
    
    let myDate = Date(timeIntervalSince1970:  epocTime)
    let dateFormatter2 = DateFormatter()
    dateFormatter2.timeStyle = DateFormatter.Style.medium //Set time style
    dateFormatter2.dateStyle = DateFormatter.Style.medium //Set date style
    dateFormatter2.dateFormat = "HH:mm";
    dateFormatter2.timeZone = TimeZone.current
    let localDate = dateFormatter2.string(from: myDate as Date)
    return localDate
}


   /*class Models: NSObject {
    static var models = Models()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var  Today:TeacherScheduleTodayModels?
    var TeacherSub :TeacherMySubject?
    class func sharedController()->Models {
        return self.models
    }*/



