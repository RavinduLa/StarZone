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
    var price : Double
    
    override init() {
        self.itemId = ""
        self.itemName = ""
        self.itemDescription = ""
        self.price = 0.0
    }
    
    init(id: String, name : String, description : String, price : Double) {
        self.itemId = id
        self.itemName = name
        self.itemDescription = description
        self.price = price
    }
}
