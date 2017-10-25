//
//  SharedClass.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/16/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import Foundation
import UIKit

public class SharedClass {
     var teacherSelectedSubject:TeacherMySubject!
    var superViewController:UIViewController!
    var techerSelectedTimeLine:TimeLineModel!
    var teacherSelectedSubjectToAddmarks:TeacherMySubject!
    var teacherSelectedSubjectToAddmessage:TeacherMySubject!
    var parentSelectedChildToAddmessage:ChildMySubject!
    var teacherSelectedContactToSendMessage:SendMessageModel!
    var parentSelectedChild:ChildMySubject!
    var timelineClass:Int!
    var userid:Int!
    var p:Int!
    var k:Int!
    var userrole:String!
    var apihelper:Any?
    
    static let sharedInstance = SharedClass()
    
}
