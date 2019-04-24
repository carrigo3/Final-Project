//
//  MyClosetUserProfileViewController.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/23/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class MyClosetUserProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userDisplayNameLabel: UILabel!
    
    var authUI: FUIAuth!
    var myClosetUser: MyClosetUser! {
        didSet {
            userEmailLabel.text = myClosetUser.email
            userDisplayNameLabel.text = myClosetUser.displayName
            profileImageView.image = UIImage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ReturnToItemCollectionView", sender: self)
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        do {
            try authUI!.signOut()
            print("^^^ Successfully signed out!")
            view.isHidden = true
            performSegue(withIdentifier: "ReturnToItemCollectionView", sender: self)
        } catch {
            view.isHidden = true
            print("*** ERROR: Couldn't sign out")
        }
    }
    
}
