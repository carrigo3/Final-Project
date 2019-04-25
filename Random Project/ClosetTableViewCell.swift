//
//  ClosetTableViewCell.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/24/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import UIKit

class ClosetTableViewCell: UITableViewCell {
    @IBOutlet weak var closetCellImageView: UIImageView!
    @IBOutlet weak var closetCellLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
        
    }
    

    



}
