//
//  ClosetViewController.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/23/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import UIKit

class ClosetViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let minHeight: CGFloat = 100
    
    var cellSpacingHeight: CGFloat = 15
    var closetOptionsArray = ["Add Item To Closet", "All Clothes", "Clean/Dirty Clothes", "Loaned Out Clothes", "Browse by Section"]
    var segueIdentifiers = ["AddNewItem", "ShowAllClothesCollection"]
    var currentUserDocumentID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.isToolbarHidden = true
        view.backgroundColor?.withAlphaComponent(0.5)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNewItem" {
            let destination = segue.destination.children[0] as! AddNewItemViewController
            let currentDocumentID = currentUserDocumentID
            destination.currentDocumentID = currentDocumentID
        } else {
            return
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
         performSegue(withIdentifier: "BackFromCloset", sender: self)
    }
    
    
}

extension ClosetViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return closetOptionsArray.count
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
        cell.closetCellLabel.text = closetOptionsArray[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewHeight = tableView.bounds.height
        let desiredCellHeight = tableViewHeight/CGFloat(closetOptionsArray.count) - 20
        return (desiredCellHeight > minHeight ? desiredCellHeight : minHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifiers[indexPath.section], sender: self)
    }
    
    
}
