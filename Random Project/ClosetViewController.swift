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
    @IBOutlet weak var searchBar: UISearchBar!
    
    let minHeight: CGFloat = 100
    
    var cellSpacingHeight: CGFloat = 15
    var currentUserDocumentID: String!
    var clothesItems: ClothesItems!
    var clothesItem: ClothesItem!
    //var currentClothesItemsArray = [ClothesItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        //searchBar.delegate = self
        navigationController?.isToolbarHidden = true
        view.backgroundColor?.withAlphaComponent(0.5)
        clothesItems = ClothesItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        case "ShowClothesItem" :
            print("ShowClothesItem segue executed")
            let destination = segue.destination as! ClothesItemDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.clothesItem = clothesItems.clothesItemsArray[selectedIndexPath.section]
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
        
    }
}

//extension ClosetViewController: UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard !searchText.isEmpty else {
//            currentClothesItemsArray = clothesItems.clothesItemsArray
//            tableView.reloadData()
//            return
//        }
//        currentClothesItemsArray = clothesItems.clothesItemsArray.filter({ (clothesItem) -> Bool in
//            return clothesItem.itemName.lowercased().contains(searchText.lowercased())
//        })
//        tableView.reloadData()
//    }
//
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        switch selectedScope {
//        case 0:
//            currentClothesItemsArray = clothesItems.clothesItemsArray
//        case 1:
//            currentClothesItemsArray = clothesItems.clothesItemsArray.filter({ (clothesItem) -> Bool in
//                clothesItem.itemStatus == "Clean"
//            })
//        case 2:
//            currentClothesItemsArray = clothesItems.clothesItemsArray.filter({ (clothesItem) -> Bool in
//                clothesItem.itemStatus == "Dirty"
//            })
//        case 3:
//            currentClothesItemsArray = clothesItems.clothesItemsArray.filter({ (clothesItem) -> Bool in
//                clothesItem.itemStatus == "Loaned Out"
//            })
//        default:
//            print("I have absolutely no idea how you got here, but congratulations")
//            return
//        }
//        tableView.reloadData()
//    }
//}
