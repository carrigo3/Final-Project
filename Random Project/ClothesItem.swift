//
//  ClothesItem.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/24/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ClothesItem {
    var itemName: String
    var itemSection: String
    var lastWornDate: TimeInterval
    var itemStatus: String
    var itemImage: UIImage
    var documentUUID: String
    
    var dictionary: [String: Any] {
        return ["itemName": itemName, "itemSection": itemSection, "lastWornDate": lastWornDate, "itemStatus": itemStatus]
    }
    
    init (itemName: String, itemSection: String, lastWornDate: TimeInterval, itemStatus: String, itemImage: UIImage, documentUUID: String) {
        self.itemName = itemName
        self.itemSection = itemSection
        self.lastWornDate = lastWornDate
        self.itemStatus = itemStatus
        self.itemImage = itemImage
        self.documentUUID = documentUUID
    }
    
    convenience init (){
        self.init(itemName: "", itemSection: "", lastWornDate: TimeInterval(), itemStatus: "", itemImage: UIImage(), documentUUID: "")
    }
    
    convenience init (dictionary: [String: Any]) {
        let itemName = dictionary["itemName"] as! String? ?? ""
        let itemSection = dictionary["itemSection"] as! String? ?? ""
        let lastWornDate = dictionary["lastWornDate"] as! TimeInterval? ?? TimeInterval()
        let itemStatus = dictionary["itemStatus"] as! String? ?? ""
        self.init(itemName: itemName, itemSection: itemSection, lastWornDate: lastWornDate, itemStatus: itemStatus, itemImage: UIImage(), documentUUID: "")
   }
    
    func saveData(currentDocumentID: String, completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        let storage = Storage.storage()
        //convert photo.image to a data type so it can be saved by Firebase Storage
        guard let photoData = self.itemImage.jpegData(compressionQuality: 0.5) else {
            print("*** ERROR: could not convert image to data format")
            return completed(false)
        }
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        documentUUID = UUID().uuidString //Generate a unique ID to use for the photo image's name
        // create a ref to upload storage to spot.documentID's folder (bucket), with the name we created.
        let storageRef = storage.reference().child(currentDocumentID).child(self.documentUUID)
        let uploadTask = storageRef.putData(photoData, metadata: uploadMetadata)
        {metadata, error in
            guard error == nil else {
                print("*** ERROR: Error during .putData storage upload for \(storageRef). Error: \(error!.localizedDescription)")
                return
            }
        }
        uploadTask.observe(.success) { (snapshot) in
            let dataToSave = self.dictionary
            // This will either create a new doc at documentUUID or update the existing doc with that name
            let ref = db.collection("users").document(currentDocumentID).collection("clothes").document(self.documentUUID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("*** ERROR: updating document \(self.documentUUID) in spot \(currentDocumentID) \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ Document updated with ref ID \(ref.documentID)")
                    print("\(String(describing: self.dictionary["coordinate"]))")
                    completed(true)
                }
            }
        }
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error {
                print("*** ERROR: upload task for file \(self.documentUUID) failed, in spot \(currentDocumentID) Error: \(error.localizedDescription)")
            }
            return completed(false)
        }
    }
}
