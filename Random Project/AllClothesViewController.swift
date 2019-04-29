//////
//////  AllClothesViewController.swift
//////  Random Project
//////
//////  Created by Cameron Arrigo on 4/25/19.
//////  Copyright © 2019 Cameron Arrigo. All rights reserved.
//////
////
//import UIKit
//import Firebase
//
//class AllClothesViewController: UIViewController {
//    @IBOutlet weak var collectionView: UICollectionView!
//
//    var allClothesItemImages: [UIImage]!
//    var currentDocumentID: String!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//
//    }
//
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        if segue.identifier == "BackToCloset" {
////            let destination = segue.destination.children[0] as! ClosetViewController
////            destination.currentUserDocumentID = currentDocumentID
////        } else {
////            return
////        }
////    }
////
//    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "BackToCloset", sender: self)
//    }
//
//}
//
//extension AllClothesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return allClothesItemImages.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AllClothesCollectionViewCell
//        cell.cellImageView.image = allClothesItemImages[indexPath.row]
//        return cell
//    }
//
//
//}
