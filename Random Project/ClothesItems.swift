//
//  ClothesItems.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/25/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import Foundation
import Firebase

class ClothesItems {
    var clothesItemsArray = [ClothesItem]()
    var db: Firestore!
    
    init () {
        db = Firestore.firestore()
    }
    
    func loadData(currentDocumentID: String, completed: @escaping () -> ()) {
        guard currentDocumentID != "" else {
            return
        }
        let storage = Storage.storage()
        db.collection("users").document(currentDocumentID).collection("clothes").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshpot listener \(error!.localizedDescription)")
                return completed()
            }
            self.clothesItemsArray = []
            var loadAttempts = 0
            let storageRef = storage.reference().child(currentDocumentID)
            for document in querySnapshot!.documents {
                let clothesItem = ClothesItem(dictionary: document.data())
                clothesItem.documentUUID = document.documentID
                self.clothesItemsArray.append(clothesItem)
                
                let clothesItemRef = storageRef.child(clothesItem.documentUUID)
                clothesItemRef.getData(maxSize: 25 * 1025 * 1025) { data, error in
                    if let error = error {
                        print("*** ERROR: An error occured while reading data from file ref \(clothesItemRef) \(error.localizedDescription)")
                        loadAttempts += 1
                        if loadAttempts >= (querySnapshot!.count) {
                            return completed()
                        }
                    } else {
                        let image = UIImage(data: data!)
                        clothesItem.itemImage = image!
                        loadAttempts += 1
                        if loadAttempts >= (querySnapshot!.count) {
                            return completed()
                        }
                    }
                }
            }
            completed()
        }
    }
}
