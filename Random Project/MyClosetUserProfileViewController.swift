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
import SDWebImage

class MyClosetUserProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userDisplayNameLabel: UILabel!
    
    var authUI: FUIAuth!
    var myClosetUser: MyClosetUser!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        let currentUser = authUI.auth?.currentUser
        myClosetUser = MyClosetUser(user: currentUser!)
        userEmailLabel.text = myClosetUser.email
        userDisplayNameLabel.text = myClosetUser.displayName
        guard let url = URL(string: myClosetUser.photoURL) else {
            // TODO: Create a standard user profile image to go in here
            print("*** ERROR: cannot convert photoURL String to a URL")
            return
        }
        profileImageView.sd_setImage(with: url)
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
extension MyClosetUserProfileViewController: FUIAuthDelegate {
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let user = user {
            view.isHidden = false
            print("^^^ We signed in with the user \(user.email ?? "unknown e-mail")")
        }
    }
}
