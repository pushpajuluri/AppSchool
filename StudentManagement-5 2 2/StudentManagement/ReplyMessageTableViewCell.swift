//
//  ReplyMessageTableViewCell.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 8/29/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class ReplyMessageTableViewCell: UITableViewCell {

    var replyMessage:MessagesModel!
    @IBOutlet weak var replyMessageTxtField: UITextField!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    
    @IBAction func replyBtnAction(sender:UIButton!)-> Void{
        replyMessageTxtField.isHidden=false
        btnSend.isHidden = false
        sender.isHidden=true
        
    }
    
     override func awakeFromNib() {
        super.awakeFromNib()
        
        
      //  replyMessageTxtField.backgroundColor=UIColor.cyan
        replyMessageTxtField.layer.borderWidth = 1
        replyMessageTxtField.borderColor = UIColor.black
        replyMessageTxtField.isHidden=true
        btnSend.isHidden = true
        //btnSend.backgroundColor = UIColor.red
        replyButton.addTarget(self, action: #selector(self.replyBtnAction(sender:)), for: .touchUpInside)
        btnSend.addTarget(self, action: #selector(self.sendmessage(sender:)), for: .touchUpInside)
        // Initialization code
    }

    func sendmessage(sender:UIButton!)-> Void{
        
        self.replyMessageTxtField.isHidden = true
        self.btnSend.isHidden = true
        replyButton.isHidden = false
        let selectedMessage = self.btnSend.tag
        print(selectedMessage)
        // let replyMessageObj = sectionMessages.replymessagesArray[messageCell.replyButton.tag]
        //  let replyMessage = sectionMessages.replymessagesArray[selectedMessage]
        
        print(replyMessage)
        print(sender.tag)
        if(SharedClass.sharedInstance.userrole == "TEACHER")
        {
        if (replyMessage.sentflag == "T")
        {
           // var bodyArray = [String:Any]
            
            let bodyArray =  ["senderid":replyMessage.senderid,"recieverid":replyMessage.recieverid,"message":self.replyMessageTxtField.text,"id":replyMessage.id] as [String : Any]
           // bodyArray.append(aDict)
            
            ApiHelper.sharedController().callToSendReplyMessage(bodyArray: bodyArray,successblock: { (todayResult) in
                print("reply message was sent \(todayResult!)")
            },FailureBlock: nil, viewController: nil)
            
        }
        else if  (replyMessage.sentflag == "P")
        {
          //  var bodyArray = [[String:Any]]()
            
            let bodyArray =  ["senderid":replyMessage.recieverid,"recieverid":replyMessage.senderid,"message":self.replyMessageTxtField.text,"id":replyMessage.id] as [String : Any]
         //   bodyArray.append(aDict)
            
            ApiHelper.sharedController().callToSendReplyMessage(bodyArray: bodyArray,successblock: { (todayResult) in
                print("reply message was sent \(todayResult!)")
            },FailureBlock: nil, viewController: nil)
            
        }
    }
        else{
            if (replyMessage.sentflag == "P")
            {
                // var bodyArray = [String:Any]
                
                let bodyArray =  ["senderid":replyMessage.senderid,"recieverid":replyMessage.recieverid,"message":self.replyMessageTxtField.text,"id":replyMessage.id] as [String : Any]
                // bodyArray.append(aDict)
                
                ApiHelper.sharedController().callToSendReplyMessageparent(bodyArray: bodyArray,successblock: { (todayResult) in
                    print("reply message was sent \(todayResult!)")
                },FailureBlock: nil, viewController: nil)
                
            }
            else if  (replyMessage.sentflag == "T")
            {
                //  var bodyArray = [[String:Any]]()
                
                let bodyArray =  ["senderid":replyMessage.recieverid,"recieverid":replyMessage.senderid,"message":self.replyMessageTxtField.text,"id":replyMessage.id] as [String : Any]
                //   bodyArray.append(aDict)
                
                ApiHelper.sharedController().callToSendReplyMessageparent(bodyArray: bodyArray,successblock: { (todayResult) in
                    print("reply message was sent \(todayResult!)")
               //    MessagesViewController.SentMessages(techerSelectedClassValue: teacherSubArray[SharedClass.sharedInstance.k])
                },FailureBlock: nil, viewController: nil)
                
            }

            
        }
    }
    


}
