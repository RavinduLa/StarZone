//
//  CartItem.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-13.
//

//import Foundation
import UIKit

class CartItem : NSObject{
    var productItem : ProductItem
    var count : Int = 1{
        didSet{
            if count <= 0{
                count = 1
            }
        }
    }
    var cartItemPrice : Double {
        get{
            return self.productItem.price * Double(count)
        }
    }
    
    
    init(product : ProductItem, count : Int) {
        self.productItem = product
        self.count = count
    }
}
