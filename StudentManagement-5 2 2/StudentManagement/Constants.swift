//
//  Constants.swift
//  QuickDeal
//
//  Created by RadhaKrishna on 05/07/16.
//  Copyright © 2016 QuickDeal. All rights reserved.
//

import Foundation
import UIKit

struct Constants
{
    static let APP_STORE_URL = "www.apple.com"
  // static let APP_URL =  "http://192.168.1.20:8080"
   static let APP_URL = "http://api.ischool.omniwyse.co.in"
 //   " http://192.168.1.22:8085"
//192.168.0.62
    //13.126.88.224
  //  static let APP_COLOR = UIColor.colorFromHexString(hexString: "#000000", withAlpha: 1.0)
  //  static let APP_BG_COLOR = UIColor.colorFromHexString(hexString: "#040707", withAlpha: 1.0)
   
    //Screen width
    static let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height

    
    //IMG Path
    //static let IMG_LOCAL_PATH = "\(NSObject().getDocumentDirectoryPath())/Aiqudo"

    static let TOAST_DURATION = 2.0
    static let TIME_OUT = 60.0
    static let GET = "GET"
    static let POST = "POST"
    static let DELETE = "DELETE"
    static let PUT = "PUT"
    static let UPDATE = "UPDATE"
    
    static let CONTENT_TYPE_JSON = "application/json"
    static let CONTENT_TYPE_ENCODING = "application/x-www-form-urlencoded"

    //Fonts
    static let FONT_STYLE = "Roboto"
    static let REGULAR_FONT_STYLE = "Roboto-Regular"
    static let BOLD_FONT_STYLE = "Roboto-Bold"
    static let MEDIUM_FONT_STYLE = "Roboto-Medium"

    //Messages
    static let MSG_NO_INTERNET = "Check your internet connection"
    static let MSG_NO_DETAILS = "No details are available"
    static let MSG_EMPTY = "Fields can not be empty"
    
    //Json Keys
    static let STATUS = "status"
    static let RESPONSE = "response"
    static let REASON = "reason"
    static let SUCCESS = "success"
    
    //Default Images
    static let IMG_BG_HOME = UIImage(named:"homeBg")
    static let IMG_USER = UIImage(named:"user-default")

        static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}
