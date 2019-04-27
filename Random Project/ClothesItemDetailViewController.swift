//
//  ClothesItemDetailViewController.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/26/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import UIKit


class ClothesItemDetailViewController: UIViewController {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemSectionLabel: UILabel!
    @IBOutlet weak var itemStatusLabel: UILabel!
    @IBOutlet weak var lastWornDateLabel: UILabel!
    
    var clothesItem: ClothesItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
    }

    func updateUserInterface() {
        itemImageView.image = clothesItem.itemImage
        itemNameLabel.text = clothesItem.itemName
        itemSectionLabel.text = clothesItem.itemSection
        lastWornDateLabel.text = formatDate(timeInterval: clothesItem.lastWornDate)
        formatStatusLabel()
    }
    
    func formatDate(timeInterval: TimeInterval) -> String {
        let usableDate = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: usableDate)
    }
    
    func formatStatusLabel() {
        switch clothesItem.itemStatus {
        case "Clean" :
            itemStatusLabel.textColor = UIColor.green
            itemStatusLabel.text = clothesItem.itemStatus
        case "Dirty", "Loaned Out" :
            itemStatusLabel.textColor = UIColor.red
            itemStatusLabel.text = clothesItem.itemStatus
        default:
            print("*** ERROR: Something went wrong here.")
        }
    }

    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
    }
    
}
