//
//  Outfit.swift
//  Random Project
//
//  Created by Cameron Arrigo on 4/29/19.
//  Copyright © 2019 Cameron Arrigo. All rights reserved.
//

import Foundation
import Firebase

class Outfit {
    var outfitName: String
    var hatImage: UIImage
    var shirtImage: UIImage
    var beltImage: UIImage
    var pantsImage: UIImage
    var shoesImage: UIImage
    var jacketImage: UIImage
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["outfitName": outfitName]
    }
    
    init(outfitName: String, hatImage: UIImage, shirtImage: UIImage, beltImage: UIImage, pantsImage: UIImage, shoesImage: UIImage, jacketImage: UIImage, documentID: String) {
        self.outfitName = outfitName
        self.hatImage = hatImage
        self.shirtImage = shirtImage
        self.beltImage = beltImage
        self.pantsImage = pantsImage
        self.shoesImage = shoesImage
        self.jacketImage = jacketImage
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(outfitName: "", hatImage: UIImage(), shirtImage: UIImage(), beltImage: UIImage(), pantsImage: UIImage(), shoesImage: UIImage(), jacketImage: UIImage(), documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let outfitName = dictionary["outfitName"] as! String? ?? ""
        self.init(outfitName: outfitName, hatImage: UIImage(), shirtImage: UIImage(), beltImage: UIImage(), pantsImage: UIImage(), shoesImage: UIImage(), jacketImage: UIImage(), documentID: "")
    }
    
    func saveData(currentUser: MyClosetUser, completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        let dataToSave = self.dictionary
        var ref: DocumentReference? = nil
        ref = db.collection("users").document(currentUser.documentID).collection("outfits").addDocument(data: dataToSave)
        { (error) in
            if let error = error {
                print("*** ERROR: creating new document in spot \(currentUser.documentID) for new outfit documentID \(error.localizedDescription)")
                completed(false)
            } else {
                print("^^^ Document added with ref ID: \(ref?.documentID ?? "Unknown")")
                completed(true)
            }
        }
    }
}
