//
//  OutfitTableViewCell.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/29/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import UIKit

class OutfitTableViewCell: UITableViewCell {
    @IBOutlet weak var outfitImageView: UIImageView!
    @IBOutlet weak var itemTypeLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5.0
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 5, height: 5)
        self.clipsToBounds = false
    }
    
    func configureCell(outfitTypeLabel: String) {
        itemTypeLabel.text = outfitTypeLabel
    }

}
