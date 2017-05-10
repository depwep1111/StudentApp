//
//  StudentDetailTableViewController.swift
//  StudentApp
//
//  Created by Cntt06 on 5/10/17.
//  Copyright © 2017 Cntt06. All rights reserved.
//

import UIKit

class StudentDetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var studentModel: Student!
    @IBOutlet weak var imageStudent: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textID: UITextField!
    @IBOutlet weak var textSchool: UITextField!
    @IBOutlet weak var textAge: UITextField!
    @IBOutlet weak var textDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        textName.text = studentModel.name
        textID.text = studentModel.id
        textAge.text = studentModel.age
        textSchool.text = studentModel.university
        textDescription.text = studentModel.descript
        imageStudent.image = studentModel.image

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Pick a picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageStudent.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK : - User press choose image
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
    
    // MARK: - User click button save
    
    @IBAction func btnSaveAction(_ sender: UIBarButtonItem) {
        if textName.text!.isEmpty || textID.text!.isEmpty || textSchool.text!.isEmpty ||  textDescription.text!.isEmpty ||  textAge.text!.isEmpty{
            //create alert
            let alert = UIAlertController(title: "Notification", message: "Please enter full information", preferredStyle: UIAlertControllerStyle.alert);
            //add an action
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
        }
        else {
            studentModel.name = textName.text!
            studentModel.id = textID.text!
            studentModel.university = textSchool.text!
            studentModel.age = textAge.text!
            studentModel.descript = textDescription.text!
            studentModel.image = imageStudent.image!
        }
        // Back To Management Student Screen
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITextFieldDelegate ( Keyboard will  disable when press return )
    // User must set delegate from this textfield to this view
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textFieldName.resignFirstResponder()
        /*textFieldID.resignFirstResponder()
         textFieldAge.resignFirstResponder()
         textFieldUni.resignFirstResponder()*/
        if textName.isEditing {
            textName.resignFirstResponder()
        } else if textSchool.isEditing {
            textSchool.resignFirstResponder()
        }
        return true
    }
    
    
    // MARK: - UIScrollViewDelegate ( Keyboard will disable when scroll the UIView )
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        textName.resignFirstResponder()
        textID.resignFirstResponder()
        textAge.resignFirstResponder()
        textSchool.resignFirstResponder()
        textDescription.resignFirstResponder()
    }

}
