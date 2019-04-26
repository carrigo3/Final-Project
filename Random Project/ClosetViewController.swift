//
//  ClosetViewController.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/23/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import UIKit
import Firebase

class ClosetViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let minHeight: CGFloat = 100
    
    var cellSpacingHeight: CGFloat = 15
    // Change below to be all cell information
    //var closetOptionsArray = ["Add Item To Closet", "All Clothes", "Clean/Dirty Clothes", "Loaned Out Clothes", "Browse by Section"]
    var segueIdentifiers = ["AddNewItem", "ShowAllClothesCollection"]
    var currentUserDocumentID: String!
    var clothesItems: ClothesItems!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.isToolbarHidden = true
        view.backgroundColor?.withAlphaComponent(0.5)
        clothesItems = ClothesItems()
        clothesItems.loadData(currentDocumentID: currentUserDocumentID) {
            print("***DATA LOADEDDDDDDD")
            self.tableView.reloadData()
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "AddNewItem" :
            let destination = segue.destination as! AddNewItemViewController
            let currentDocumentID = currentUserDocumentID
            destination.currentDocumentID = currentDocumentID
//        case "ShowAllClothesCollection" :
//            let navigationController = segue.destination as! UINavigationController
//            let destination = navigationController.viewControllers.first as! AllClothesViewController
//            destination.allClothesItemImages = itemImages
//            destination.currentDocumentID =
        default :
            print("*** ERROR: Did not have a segue in ClosetViewController prepare(for segue:)")
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
         performSegue(withIdentifier: "BackFromCloset", sender: self)
    }
    
    
}

extension ClosetViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return clothesItems.clothesItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = self.view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClosetCell", for: indexPath) as! ClosetTableViewCell
        cell.configureCell(clothesItem: clothesItems.clothesItemsArray[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: segueIdentifiers[indexPath.section], sender: self)
        
    }
    
    
}
