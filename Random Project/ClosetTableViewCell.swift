//
//  ClosetTableViewCell.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/24/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import UIKit

class ClosetTableViewCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemStatusLabel: UILabel!
    @IBOutlet weak var itemSectionLabel: UILabel!
    @IBOutlet weak var itemLastWornLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!

    var clothesItem: ClothesItem!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
    }
    
    func configureCell(clothesItem: ClothesItem) {
        itemNameLabel.text = clothesItem.itemName
        itemSectionLabel.text = clothesItem.itemSection
        itemImageView.image = clothesItem.itemImage
        print(clothesItem.lastWornDate)
        //itemLastWornLabel.text = clothesItem.lastWornDate
        switch clothesItem.itemStatus {
        case "Clean" :
            itemStatusLabel.textColor = UIColor.green
            itemStatusLabel.text = clothesItem.itemStatus
        case "Dirty" :
            itemStatusLabel.textColor = UIColor.red
            itemStatusLabel.text = clothesItem.itemStatus
        case "Loaned Out" :
            itemStatusLabel.textColor = UIColor.red
            itemStatusLabel.text = clothesItem.itemStatus
        default:
            print("*** ERROR: Something went wrong here.")
        }
        
    }
    

    



}
