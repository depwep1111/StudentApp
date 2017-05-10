//
//  MangementStudentTableTableViewController.swift
//  StudentApp
//
//  Created by Cntt06 on 5/10/17.
//  Copyright © 2017 Cntt06. All rights reserved.
//

import UIKit

class MangementStudentTableTableViewController: UITableViewController, UISearchBarDelegate {
    // get student
    lazy var students: [Student] = {
        return Student.createStudent()
    }()
    //get students for search
    lazy var initialStudent: [Student] = {
        return Student.createStudent()
    }()
    let searchBar = UISearchBar(frame: CGRect(x:0,y:0,width:(UIScreen.main.bounds.width),height:70))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = editButtonItem
        self.searchBarSetup()
    }
    func searchBarSetup() {
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Name","ID","Age","School"]
        searchBar.selectedScopeButtonIndex = 0
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
    }
    // MARK: - search bar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
        if searchText.isEmpty {
            students = initialStudent
            self.tableView.reloadData()
        }else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func filterTableView(ind:Int,text:String) {
        tableView.reloadData()
        switch ind {
        case 0:
            //fix of not searching when backspacing
            students = initialStudent.filter({ (stu) -> Bool in
                return stu.name.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
            
        case 1:
            //fix of not searching when backspacing
            students = initialStudent.filter({ (stu) -> Bool in
                return stu.id.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
            
        case 2:
            //fix of not searching when backspacing
            students = initialStudent.filter({ (stu) -> Bool in
                return stu.age.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
            
        case 3:
            //fix of not searching when backspacing
            students = initialStudent.filter({ (stu) -> Bool in
                return stu.university.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Type Found!!!")
        }
    }
    // UIScrollViewDelegate ( Keyboard will disable when scroll the UIView )
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StudentTableViewCell

        // Configure the cell...

        let student = students[indexPath.row]
        
        cell.labelName.text = student.name
        cell.labelID.text = student.id
        cell.labelSchool.text = student.university
        cell.labelAge.text = student.age
        cell.imgStudent.image = student.image
        
        return cell
    }
    //show detail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detail") {
            
            let studentDetailVC = segue.destination as! StudentDetailTableViewController
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let student: Student
                student = students[indexPath.row]
                studentDetailVC.studentModel = student
            }
        }
    }
    //MARK: - Delete when user swipe to left
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            students.remove(at: indexPath.row)
            //update table view with new data source
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            initialStudent = students // reload initialStudent
        }
    }
    //MARK: - Sort when user click edit button
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //get data in sourceIndexPath
        let currentStudent = students[sourceIndexPath.row];
        students.remove(at: sourceIndexPath.row)
        students.insert(currentStudent, at: destinationIndexPath.row)
        initialStudent = students // reload initialStudent
    }

    
    

}
