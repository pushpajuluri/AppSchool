//
//  DashboardViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 7/24/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit
import Material

enum ScheduleType:Int {
    
    case TODAY = 0
    case TOMORROW
    case WEEKLY
    
    func descrip() -> String {
        if self == .TODAY {
            return "Today"
        }
        else if self == .TOMORROW {
            return "Tomorrow"
        }
        else
        {
            return "Weekly"
        }
    }
}


 enum DashboardType:Int {
    case SCHEDULE = 0
    case BIRTHDAY
    case TODO
    case NEWS
    case EVENTS
    case HOLIDAYS
}


class DashboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!

      var childSubArray = [ChildMySubject]()
    //Queues
    var apiCallGrp = DispatchGroup()
    var apiCallQueue = DispatchQueue(label: "com.StudentManagement.dashboard", qos: .userInitiated, attributes:  .concurrent)
    
    lazy var dashBoardModel = DashBoardModel()
    var selectedSchedule = ScheduleType.TODAY
    let headerHeight:Double = 70.0
    
    override func viewDidLoad() {
        self.title = "Home"
        self.selectedSchedule = ScheduleType(rawValue: 0)!
        self.initiateAPICalls()
        if(SharedClass.sharedInstance.userrole == "PARENT"){
        getMyChildren()
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func initiateAPICalls() {
        apiCallGrp.enter()
        apiCallQueue.async {
          //  self.todaybirthdays()
        }
        
        apiCallGrp.enter()
        apiCallQueue.async {
            if(SharedClass.sharedInstance.userrole == "TEACHER"){
            self.callToGetTodaySchedule()
            }
        }
        apiCallGrp.enter()
        apiCallQueue.async {
            if(SharedClass.sharedInstance.userrole == "TEACHER"){
            self.callToGetTommorowSchedule()
            }
        }
        apiCallGrp.enter()
        apiCallQueue.async {
          //  self.tommorowbirthdays()
        }
        apiCallGrp.enter()
        apiCallQueue.async {
            self.getNews()
        }
        if(SharedClass.sharedInstance.userrole == "PARENT"){
            apiCallGrp.enter()
            apiCallQueue.async {
                self.getNotification()
            }
        }
        
        apiCallGrp.enter()
        apiCallQueue.async {
            self.getHolidays()
        }
        apiCallGrp.enter()
        apiCallQueue.async {
            self.getEvents()
        }
      
        apiCallGrp.notify(queue: DispatchQueue.main) {
            print("ALL Apis are completed")
            
            self.tableview.reloadData()
        }
    }
   
    
    //API call for news
    func getNews()  {
        ApiHelper.sharedController().callToGetNews(successblock: { (resultArray) in
            
            print("Get news response\(resultArray!)")
            var newsArray =  [newsModel]()
            
            for dict in resultArray!{
                newsArray.append(newsModel.parseData(dict: dict))
            }
            self.dashBoardModel.newsesArray = newsArray
            self.tableview.reloadData()
            //Leave from the group
            self.apiCallGrp.leave()
            
        }, FailureBlock: nil, viewController: self)
    }
    //API call for notification
    func getNotification()  {
        ApiHelper.sharedController().callToGetNotification(successblock: { (resultArray) in
            
            print("Get notification\(resultArray!)")
            var todoArray =  [TodaysToDosModels]()
            
            for dict in resultArray!{
               todoArray.append(TodaysToDosModels.parseData(dict: dict))
            }
            self.dashBoardModel.todoArray = todoArray
            self.tableview.reloadData()
            //Leave from the group
            self.apiCallGrp.leave()
            
        }, FailureBlock: nil, viewController: self)
    }


    //API call for holidays
    func getHolidays()  {
        ApiHelper.sharedController().callToGetHoliday(successblock: { (resultArray) in
            
            print("Get holidays response\(resultArray!)")
                        var holidayArray =  [holidayModel]()
            
                        for dict in resultArray!{
                            holidayArray.append(holidayModel.parseData(dict: dict))
                        }
            self.dashBoardModel.holidaysArray = holidayArray
            self.tableview.reloadData()
            //Leave from the group
            self.apiCallGrp.leave()
            
            
        }, FailureBlock: nil, viewController: self)
    }

    //API call for events
    func getEvents()  {
        ApiHelper.sharedController().callToGetEvents(successblock: { (resultArray) in
            
            print("Get event response\(resultArray!)")
                        var eventArray =  [eventModel]()
            
                        for dict in resultArray!{
                            eventArray.append(eventModel.parseData(dict: dict))
                        }
                        self.dashBoardModel.eventsArray = eventArray
                        self.tableview.reloadData()

            //Leave from the group
            self.apiCallGrp.leave()
            
            
        }, FailureBlock: nil, viewController: self)
    }


    //API call for birthdays
    func todaybirthdays()  {
        ApiHelper.sharedController().callToGetMybirthday(successblock: { (resultArray) in
            
          print("Get birthday response \(resultArray!)")
            var birthDayArray =  [BirthdaysModels]()

            for dict in resultArray!{
                birthDayArray.append(BirthdaysModels.parseData(dict: dict))
            }
            self.dashBoardModel.birthdayArray = birthDayArray
            self.tableview.reloadData()
            //Leave from the group
            self.apiCallGrp.leave()
            

        }, FailureBlock: nil, viewController: self)
    }
    
    //API call to get tommorow birthday
    func tommorowbirthdays()  {
        ApiHelper.sharedController().callToGetMybirthdayTommorrow(successblock: { (tommorowBirthday) in
            
            print("Get birthday response \(tommorowBirthday!)")
            var birthDayArray =  [BirthdaysModels]()
            
            for dict in tommorowBirthday!{
                birthDayArray.append(BirthdaysModels.parseData(dict: dict))
            }
            self.dashBoardModel.tommorowBirthdayArray = birthDayArray
            
            //Leave from the group
            self.apiCallGrp.leave()
            
            
        }, FailureBlock: nil, viewController: self)
    }

    //API call to get schedule
    func callToGetTodaySchedule() {
        ApiHelper.sharedController().callToGetToday(successblock: { (todayResult) in
            print("Get today response \(todayResult!)")
            var todayArray =  [ScheduleModel]()
            for dict in todayResult!{
                  todayArray.append(ScheduleModel.parseData(dict: dict))
            }
            self.dashBoardModel.todayArray = todayArray
            
            //Leave from API Group
            self.apiCallGrp.leave()
        },FailureBlock: nil, viewController: self)
    }
    
    //API call to get tommorows schedule
    func callToGetTommorowSchedule() {
        ApiHelper.sharedController().callToGetTommorow(successblock: { (todayResult) in
            print("Get tommorow  response \(todayResult!)")
            var tommorrowArray =  [ScheduleModel]()
            for dict in todayResult!{
                tommorrowArray.append(ScheduleModel.parseData(dict: dict))
            }
            self.dashBoardModel.tommorrowArray = tommorrowArray
            
            //Leave from API Group
            self.apiCallGrp.leave()
        },FailureBlock: nil, viewController: self)
    }
   
    
    //MARK: UITAbleView methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == DashboardType.SCHEDULE.rawValue
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            //today
            if selectedSchedule == .TODAY {
                let todayobj = dashBoardModel.todayArray[indexPath.row]
                cell.textLabel?.text = todayobj.periodFrom+"- "+todayobj.periodto+"                                 "+String(todayobj.gradenumber!)+todayobj.sectionName+" "+todayobj.subjectName
            }
            else if selectedSchedule == .TOMORROW {
                let tomorrowobj = dashBoardModel.tommorrowArray[indexPath.row]
              cell.textLabel?.text = tomorrowobj.periodFrom+"- "+tomorrowobj.periodto+"                                 "+String(tomorrowobj.gradenumber!)+tomorrowobj.sectionName+" "+tomorrowobj.subjectName
            }
                
            else if selectedSchedule == .WEEKLY {
                let weeklyobj = dashBoardModel.weeklyArray[indexPath.row]
                cell.textLabel?.text = weeklyobj.periodFrom+"- "+weeklyobj.periodto
            }
            
            return cell

        }
        else if indexPath.section == DashboardType.BIRTHDAY.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            //today
            if selectedSchedule == .TODAY {
                let obj = dashBoardModel.birthdayArray[indexPath.row]
                if(dashBoardModel.birthdayArray.count >= 0){
                    
                    cell.textLabel?.text = obj.studentName
                }
                else{
                cell.textLabel?.text = "NO BIRTHDAYS"
                }
            }
            if selectedSchedule == .TOMORROW {
               
                if(dashBoardModel.birthdayArray.count >= 0){
                     let obj = dashBoardModel.tommorowBirthdayArray[indexPath.row]
                    cell.textLabel?.text = obj.studentName
                }
                else{
                    cell.textLabel?.text = "NO BIRTHDAYS"
                }

            }
            return cell

        }
        else if indexPath.section == DashboardType.NEWS.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)as!  NewsTableViewCell
            let obj = dashBoardModel.newsesArray[indexPath.row]
            cell.lblheadline.text = obj.headline
            cell.lbldescription.text = obj.description!
            cell.lblreleasedate.text = obj.releasedate

            return cell
        }
        else if indexPath.section == DashboardType.EVENTS.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)as!  EventsTableViewCell
            let obj = dashBoardModel.eventsArray[indexPath.row]
            cell.lblDescription.text = "Description:    " + obj.description!
//            cell.lblDescription.numberOfLines = 0
//            cell.lblDescription.lineBreakMode = .byWordWrapping
//            cell.lblDescription.frame.size.width = 300
//            cell.lblDescription.sizeToFit()
            cell.lbleventDate.text = obj.eventdate
            cell.lblEventName.text = obj.eventname
            cell.lblGuest.text = "Guest :" + obj.chiefguest!
            
            return cell
        }
        else if indexPath.section == DashboardType.HOLIDAYS.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)as!  HolidaysTableViewCell
            let obj = dashBoardModel.holidaysArray[indexPath.row]
           cell.lblFrm.text = obj.fromdate
            cell.lblOccasion.text = obj.occassion
            cell.lblTo.text = obj.todate
            return cell
        }
        else if indexPath.section == DashboardType.TODO.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath)as!  NotificationTableViewCell
            let obj = dashBoardModel.todoArray[indexPath.row]
            cell.lblDate.text = obj.notificationdate
            cell.lblDesc.text = obj.description
            cell.lblName.text = obj.notificationname
            
           
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            return cell
        }
    }
    
    func getMyChildren() {
        ApiHelper.sharedController().callToGetMychildren(successblock: { (todayResultMySubjects) in
            let  myNewDictArray = todayResultMySubjects as! Array<Dictionary<String, Any>>
            
            for dict in myNewDictArray{
                self.childSubArray.append(ChildMySubject.parseData(dict: dict))
            }
          
        },FailureBlock: nil,viewController: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == DashboardType.TODO.rawValue{
        let obj = dashBoardModel.todoArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if(obj.actioncode == "Timeline"){
        let timelineViewController = storyboard.instantiateViewController(withIdentifier: "MasterViewController") as! MasterViewController
        self.navigationController?.pushViewController(timelineViewController, animated: true)
            var  filterdnotification = childSubArray.filter() { $0.classid == obj.classid}
            SharedClass.sharedInstance.parentSelectedChild = filterdnotification[0] as? ChildMySubject
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Schedule
        if section == DashboardType.SCHEDULE.rawValue
        {
            if selectedSchedule == .TODAY {
               return dashBoardModel.todayArray.count
            }
            else if selectedSchedule == .TOMORROW {
                return dashBoardModel.tommorrowArray.count
            }
            else {
                return dashBoardModel.weeklyArray.count
            }
        }
            
        //Birthday
        else if section == DashboardType.BIRTHDAY.rawValue {
            return dashBoardModel.birthdayArray.count
        }
            //News
        else if section == DashboardType.NEWS.rawValue {
            return dashBoardModel.newsesArray.count
        }
        else if section == DashboardType.EVENTS.rawValue {
            return dashBoardModel.eventsArray.count
        }
        else if section == DashboardType.HOLIDAYS.rawValue {
            return dashBoardModel.holidaysArray.count
        }
        else if section == DashboardType.TODO.rawValue{
            return dashBoardModel.todoArray.count
        }

            
        //Todo
        else {
            return 0
          //  return dashBoardModel.todoArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == DashboardType.SCHEDULE.rawValue{
            return 50.0
        }else{
        return 100.0;
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(SharedClass.sharedInstance.userrole == "TEACHER"){
        if section == 0 {
            return self.getHeaderForSchedule(section: section)
        }
        else if section == 1
        {
            let spacing:Double = 5.0

            let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight))
            vi.backgroundColor = UIColor.lightGray
            
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
            lbl.text = "\(selectedSchedule.descrip()) Birthday's"
            lbl.textAlignment = .center
            vi.addSubview(lbl)
            
            let lblSpace = UILabel(frame: CGRect(x: 0, y: Double(lbl.frame.size.height), width: Double(vi.frame.size.width), height: spacing))
            lblSpace.backgroundColor = UIColor.white
            vi.addSubview(lblSpace)
            
            return vi
        }
       
//        else if section == 2
//        {
//            let spacing:Double = 5.0
//
//            let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: self.headerHeight))
//            vi.backgroundColor = UIColor.lightGray
//
//            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
//            lbl.text = "Notifications"
//            lbl.textAlignment = .center
//            vi.addSubview(lbl)
//
//            let lblSpace = UILabel(frame: CGRect(x: 0, y: Double(lbl.frame.size.height), width: Double(vi.frame.size.width), height: spacing))
//            lblSpace.backgroundColor = UIColor.white
//            vi.addSubview(lblSpace)
//
//            return vi
//
//        }
            
        else if section == 3
        {
            let spacing:Double = 5.0
            
            let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight))
            vi.backgroundColor = UIColor.lightGray
            
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
            lbl.text = "NEWS"
            lbl.textAlignment = .center
            vi.addSubview(lbl)
            
            let lblSpace = UILabel(frame: CGRect(x: 0, y: Double(lbl.frame.size.height), width: Double(vi.frame.size.width), height: spacing))
            lblSpace.backgroundColor = UIColor.white
            vi.addSubview(lblSpace)
            
            return vi
        }
        else if section == 4
        {
            let spacing:Double = 5.0
            
            let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight))
            vi.backgroundColor = UIColor.lightGray
            
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
            lbl.text = "EVENTS"
            lbl.textAlignment = .center
            vi.addSubview(lbl)
            
            let lblSpace = UILabel(frame: CGRect(x: 0, y: Double(lbl.frame.size.height), width: Double(vi.frame.size.width), height: spacing))
            lblSpace.backgroundColor = UIColor.white
            vi.addSubview(lblSpace)
            
            return vi
        }
        
        else if section == 5
        {
            let spacing:Double = 5.0
            
            let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight))
            vi.backgroundColor = UIColor.lightGray
            
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
            lbl.text = "HOLIDAYS"
            lbl.textAlignment = .center
            vi.addSubview(lbl)
            
            let lblSpace = UILabel(frame: CGRect(x: 0, y: Double(lbl.frame.size.height), width: Double(vi.frame.size.width), height: spacing))
            lblSpace.backgroundColor = UIColor.white
            vi.addSubview(lblSpace)
            
            return vi
        }
        else{
            return nil
            }
        }
        else{
            if section == 0 {
                return self.getHeaderForSchedule(section: section)
            }
//            else if section == 1
//            {
//                let spacing:Double = 5.0
//
//                let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight))
//                vi.backgroundColor = UIColor.lightGray
//
//                let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
//                lbl.text = "\(selectedSchedule.descrip()) Birthday's"
//                lbl.textAlignment = .center
//                vi.addSubview(lbl)
//
//                let lblSpace = UILabel(frame: CGRect(x: 0, y: Double(lbl.frame.size.height), width: Double(vi.frame.size.width), height: spacing))
//                lblSpace.backgroundColor = UIColor.white
//                vi.addSubview(lblSpace)
//
//                return vi
//            }
            else if section == 1{
                return nil
            }
                  else if section == 2
                        {
                            let spacing:Double = 5.0
                
                            let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: self.headerHeight))
                            vi.backgroundColor = UIColor.lightGray
                
                            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
                            lbl.text = "Notifications"
                            lbl.textAlignment = .center
                            vi.addSubview(lbl)
                
                            let lblSpace = UILabel(frame: CGRect(x: 0, y: Double(lbl.frame.size.height), width: Double(vi.frame.size.width), height: spacing))
                            lblSpace.backgroundColor = UIColor.white
                            vi.addSubview(lblSpace)
                
                            return vi
                
                        }
                
            else if section == 3
            {
                let spacing:Double = 5.0
                
                let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight))
                vi.backgroundColor = UIColor.lightGray
                
                let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
                lbl.text = "NEWS"
                lbl.textAlignment = .center
                vi.addSubview(lbl)
                
                let lblSpace = UILabel(frame: CGRect(x: 0, y: Double(lbl.frame.size.height), width: Double(vi.frame.size.width), height: spacing))
                lblSpace.backgroundColor = UIColor.white
                vi.addSubview(lblSpace)
                
                return vi
            }
            else if section == 4
            {
                let spacing:Double = 5.0
                
                let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight))
                vi.backgroundColor = UIColor.lightGray
                
                let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
                lbl.text = "EVENTS"
                lbl.textAlignment = .center
                vi.addSubview(lbl)
                
                let lblSpace = UILabel(frame: CGRect(x: 0, y: Double(lbl.frame.size.height), width: Double(vi.frame.size.width), height: spacing))
                lblSpace.backgroundColor = UIColor.white
                vi.addSubview(lblSpace)
                
                return vi
            }
                
            else if section == 5
            {
                let spacing:Double = 5.0
                
                let vi = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight))
                vi.backgroundColor = UIColor.lightGray
                
                let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: headerHeight-spacing))
                lbl.text = "HOLIDAYS"
                lbl.textAlignment = .center
                vi.addSubview(lbl)
                
                let lblSpace = UILabel(frame: CGRect(x: 0, y: Double(lbl.frame.size.height), width: Double(vi.frame.size.width), height: spacing))
                lblSpace.backgroundColor = UIColor.white
                vi.addSubview(lblSpace)
                
                return vi
            }
            else{
                return nil
            }
            
        }
        
return nil
    }
  
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(headerHeight)
    }
    
    //MARK: Header methods
    func scheduleTapped(sender:UIButton)
    {
        print(sender.tag);
        self.selectedSchedule = ScheduleType(rawValue: sender.tag)!
        self.tableview.reloadData()
    }
    
    func getHeaderForSchedule(section:Int) -> UIView {
        
        let height = headerHeight
        let spacing = 5.0
        let buttonsHeight = 40.0
        
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: Double(self.tableview.frame.size.width), height: height))
        vw.backgroundColor = UIColor.lightGray
        
        var x = 0.0
        let lblWidth:Double = Double(self.tableview.frame.size.width/3)
        
        for i in 0..<3 {
            let btnHeader = Button(frame: CGRect(x: x, y: 0.0, width: lblWidth, height: buttonsHeight))
            if i == 0 {
                btnHeader.title = "Today".uppercased()
                btnHeader.tag = ScheduleType.TODAY.rawValue
            }
            if i == 1 {
                btnHeader.title = "Tomorrow".uppercased()
                btnHeader.tag = ScheduleType.TOMORROW.rawValue
            }
            
            if i == 2 {
                btnHeader.title = "Weekly".uppercased()
                btnHeader.tag = ScheduleType.WEEKLY.rawValue
            }
            
            btnHeader.titleColor = (selectedSchedule.rawValue == i) ? UIColor.red : UIColor.black
            
            btnHeader.addTarget(self, action: #selector(self.scheduleTapped(sender:)), for: .touchUpInside)
            
            vw.addSubview(btnHeader)
            x += lblWidth
            
        }
        
        
        var lblSpace = UILabel(frame: CGRect(x: 0, y: buttonsHeight, width: Double(vw.frame.size.width), height: spacing))
        lblSpace.backgroundColor = UIColor.white
        vw.addSubview(lblSpace)
        
        let lblTimePerios = UILabel(frame: CGRect(x: 0, y: buttonsHeight+spacing, width: Double(vw.frame.size.width/2 - 5.0), height: 20))
        lblTimePerios.text = "Time_Period"
        lblTimePerios.textAlignment = .center
        vw.addSubview(lblTimePerios)
        
        
        let lblVerticalLine = UILabel(frame: CGRect(x: Double(vw.frame.size.width/2), y: buttonsHeight+spacing, width: 2.0, height: 20))
        lblVerticalLine.backgroundColor = UIColor.white
        vw.addSubview(lblVerticalLine)
        
        let lblClassSubj = UILabel(frame: CGRect(x: Double(vw.frame.size.width/2), y: buttonsHeight+spacing, width: Double(vw.frame.size.width/2 - 5.0), height: 20))
        lblClassSubj.text = "Class_Subject"
        lblClassSubj.textAlignment = .center
        
        vw.addSubview(lblClassSubj)
        
        lblSpace = UILabel(frame: CGRect(x: 0, y: buttonsHeight+spacing+Double(lblClassSubj.frame.size.height), width: Double(vw.frame.size.width), height: spacing))
        lblSpace.backgroundColor = UIColor.white
        vw.addSubview(lblSpace)
        
        return vw
    }

}







