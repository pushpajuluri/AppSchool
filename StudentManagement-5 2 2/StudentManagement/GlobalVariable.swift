//
//  GlobalVariable.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 7/20/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit


class ResponseSigninModel{
    var resDescription:String?
    var resId:Int?
    var   resSchool:String?
    var  resStatus:String?
  
}


class GlobalVariable: NSObject {

    static var globalVariable = GlobalVariable()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var  loginDetails:ResponseSigninModel?
    class func sharedController()->GlobalVariable {
        return self.globalVariable
    }
    
    

   }
