//
//  ClosetViewController.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/23/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import UIKit

class ClosetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "BackFromCloset", sender: self)
    }
}
