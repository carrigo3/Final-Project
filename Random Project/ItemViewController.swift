//
//  ItemViewController.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/23/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import GoogleSignIn
import SDWebImage

class ItemViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    let cellScaling: CGFloat = 0.6
    var authUI: FUIAuth!
    var mainItemCellLabelsArray = ["Go To My Closet", "Next Page"]
    var segueIdentifiers = ["ShowCloset", "ShowOutfitPlanner"]
    var myClosetUser: MyClosetUser! {
        didSet {
            guard let url = URL(string: myClosetUser.photoURL) else {
                // TODO: Create a standard user profile image to go in here
                print("*** ERROR: cannot convert photoURL String to a URL")
                return
            }
            profileImageView.sd_setImage(with: url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        setUpCollectionView()
        view.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        signIn()
    }
    
    func setUpCollectionView() {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
                collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }
    
    func signIn() {
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            ]
        let currentUser = authUI.auth?.currentUser
        if authUI.auth?.currentUser == nil {
            self.authUI?.providers = providers
            present(authUI.authViewController(), animated: true, completion: nil)
        } else {
            view.isHidden = false
            myClosetUser = MyClosetUser(user: currentUser!)
            myClosetUser.saveIfNewUser()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Add a switch case statement if you need another segue
        if segue.identifier == "ShowCloset" {
            let destination = segue.destination.children[0] as! ClosetViewController
            destination.currentUser = myClosetUser
        } else {
            // Add segue data passed for OutfitCreatorViewController here "ShowOutfitPlanner"
            return
        }
    }


    @IBAction func profileImageTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowDetailProfilePage", sender: self)
    }
    
}

extension ItemViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainItemCellLabelsArray.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCollectionViewCell
        cell.cellTitleLabel.text = mainItemCellLabelsArray[indexPath.row]
        return cell
    }
    
}

extension ItemViewController:  UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifiers[indexPath.row], sender: self)
    }
}

extension ItemViewController: FUIAuthDelegate {
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
