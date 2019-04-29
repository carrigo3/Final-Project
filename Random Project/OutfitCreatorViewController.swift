//
//  OutfitCreatorViewController.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/23/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import UIKit

class OutfitCreatorViewController: UIViewController {
    @IBOutlet weak var outfitNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var outfitTypeLabels = ["Hat", "Shirt", "Belt", "Pants", "Shoes", "Jacket"]
    var outfit: Outfit!
    var currentUser: MyClosetUser!
    var clothesItems: ClothesItems!
    var clotheItemsPictures: [UIImage]!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        outfit = Outfit()
//        clothesItems.loadData(currentUser: currentUser) {
//            for clothesItem in self.clothesItems.clothesItemsArray {
//                self.clotheItemsPictures.append(clothesItem.itemImage)
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clothesItems.loadData(currentUser: currentUser) {
            for clothesItem in self.clothesItems.clothesItemsArray {
                self.clotheItemsPictures.append(clothesItem.itemImage)
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if outfitNameTextField.text == "" {
            showAlert(title: "Cannot Save Outfit", message: "You must give this outfit a name in order to save")
        }
        outfit.saveData(currentUser: currentUser) { (success) in
            if success {
                print("^^^ OUTFIT DATA SAVED")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("*** ERROR: There was an error saving the outfit data, so we couldn't leave the view controller.")
            }
        }
    }
    
}

extension OutfitCreatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outfitTypeLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutfitCell", for: indexPath) as! OutfitTableViewCell
        cell.configureCell(outfitTypeLabel: outfitTypeLabels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
