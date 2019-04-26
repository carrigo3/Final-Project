//
//  AddNewItemViewController.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/24/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import UIKit
import Firebase


class AddNewItemViewController: UIViewController {
    @IBOutlet weak var newItemImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sectionPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tapToAddImageLabel: UILabel!
    @IBOutlet weak var editImageButton: UIButton!
    @IBOutlet weak var statusSegmentController: UISegmentedControl!
    
    //TODO: Add custom sections
    var sectionsArray = ["T-Shirt", "Dress Shirt", "Pants", "Sweatpants", "Sweatshirt","Shoes", "Sneakers", "Jacket"]
    var clothesItem: ClothesItem!
    var imagePicker = UIImagePickerController()
    var currentDocumentID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionPicker.delegate = self
        sectionPicker.dataSource = self
        datePicker.maximumDate = Date()
        if clothesItem == nil {
            clothesItem = ClothesItem()
            clothesItem.itemSection = sectionsArray[0]
            
        } //else {
            //to be set up if this view controller is used to edit an item
        //}
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func cameraOrLibraryAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.accessCamera()
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.accessLibrary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    


    @IBAction func editImagePressed(_ sender: UIButton) {
        cameraOrLibraryAlert()
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if nameTextField.text != "" {
            clothesItem.itemName = nameTextField.text!
            clothesItem.itemImage = newItemImageView.image!
            clothesItem.saveData(currentDocumentID: currentDocumentID) { success in
                if success {
                    self.leaveViewController()
                } else {
                    print("*** ERROR: Couldn't leave this view controller because data wasn't saved")
                }
            }
        } else {
            showAlert(title: "Cannot Save Item", message: "You must give your new clothes item a name in order to save it.")
        }

        
        
    }
    @IBAction func addImageTapped(_ sender: UITapGestureRecognizer) {
        cameraOrLibraryAlert()
    }
    @IBAction func datePicked(_ sender: UIDatePicker) {
        let date = datePicker.date
        let timeInverval = date.timeIntervalSince1970
        clothesItem.lastWornDate = timeInverval
    }
    
    @IBAction func statusValueChanged(_ sender: UISegmentedControl) {
        switch statusSegmentController.selectedSegmentIndex {
        case 0:
            clothesItem.itemStatus = "Clean"
        case 1:
            clothesItem.itemStatus = "Dirty"
        case 2:
            clothesItem.itemStatus = "Loaned Out"
        default:
            return
        }
    }
}

extension AddNewItemViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return sectionsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sectionsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        clothesItem.itemSection = sectionsArray[row]
    }
    
}

extension AddNewItemViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        newItemImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
        tapToAddImageLabel.isHidden = true
        editImageButton.isHidden = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func accessLibrary() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func accessCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            showAlert(title: "Camera Not Available", message: "There is no camera available on this device.")
        }
    }
}





