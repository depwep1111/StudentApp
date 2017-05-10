//
//  AddStudentTableViewController.swift
//  StudentApp
//
//  Created by Cntt06 on 5/10/17.
//  Copyright © 2017 Cntt06. All rights reserved.
//

import UIKit

class AddStudentTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtSchool: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var imgSt: UIImageView!
    @IBOutlet var txtDes: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Pick a picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imgSt.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnChooseImgAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK :- User press button Save
    @IBAction func btnSaveAction(_ sender: UIBarButtonItem) {
        if txtName.text!.isEmpty || txtID.text!.isEmpty || txtSchool.text!.isEmpty ||  txtDes.text!.isEmpty ||  txtDes.text!.isEmpty || imgSt.image == nil{
            //create alert
            let alert = UIAlertController(title: "Notification", message: "Please enter full information", preferredStyle: UIAlertControllerStyle.alert);
            //add an action
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
            
        }
        else {
            Constants.isLoadDataAgain = true
            let age = Int(txtAge.text!)! // "!"unwraped optional
            let student: Student = Student(named: txtName.text!, identify: txtID.text!, school: txtSchool.text!, description: txtDes.text!, aged: String(describing: age), imaged: imgSt.image!)
            Constants.student = student
            // Back To Management Student Screen
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    // UITextFieldDelegate ( Keyboard will  disable when press return )
    // User must set delegate from this textfield to this view
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtName.isEditing {
            txtID.becomeFirstResponder()
        } else if txtSchool.isEditing {
            txtAge.becomeFirstResponder()
        }
        return true
    }
    
    // UIScrollViewDelegate ( Keyboard will disable when scroll the UIView )
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        txtName.resignFirstResponder()
        txtID.resignFirstResponder()
        txtSchool.resignFirstResponder()
        txtDes.resignFirstResponder()
    }

}
