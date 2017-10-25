//
//  SelectionViewController.swift
//  StudentManagement
//
//  Created by OMNIWYSE on 6/9/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit

class SelectionModel{
    var option: String = ""
    var selection: Bool = false
     }


class SelectionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
        @IBOutlet weak var tableview: UITableView!
    var selectionArray = [SelectionModel]()

  override func viewDidLoad() {
         self.title = "List of subjects"
    
    /*super.viewDidLoad()self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add subject", style: .plain, target: self, action: #selector(AddClassViewController.addSubjectTapped))*/
    

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        

    }
    
    //MARK: UITableView data source methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let subObj = self.selectionArray[indexPath.row]
        
        cell.textLabel!.text = "\(subObj.option)".capitalized
        if subObj.selection == true {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subObj = self.selectionArray[indexPath.row]
        subObj.selection = !subObj.selection
        self.tableview.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

