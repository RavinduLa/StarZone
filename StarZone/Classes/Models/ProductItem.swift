//
//  ProductItem.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-04.
//

//import Foundation
import UIKit

class ProductItem : NSObject{
    
    var itemId : String
    var itemName : String
    var itemDescription: String
    var imageLink : String
    var price : Double
    var isFeatured : Bool
    var isNew : Bool
    var code : String
    
    override init() {
        self.itemId = ""
        self.itemName = ""
        self.itemDescription = ""
        self.imageLink = ""
        self.price = 0.0
        self.isFeatured = false
        self.isNew = false
        self.code = ""
    }
    
    init(id: String, name : String, description : String, imageLink : String, price : Double, isFeatured : Bool, isNew : Bool, code :String) {
        self.itemId = id
        self.itemName = name
        self.itemDescription = description
        self.imageLink = imageLink
        self.price = price
        self.isFeatured = isFeatured
        self.isNew = isNew
        self.code = code
    }
}
