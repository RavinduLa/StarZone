//
//  CartTableViewCell.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-13.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblItemName : UILabel!
    @IBOutlet weak var lblItemPrice : UILabel!
    @IBOutlet weak var lblItemQuantity : UILabel!
    
    //var itemQuantity : Int = 1
    var currentItem : CartItem?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func plusButtonClicked(){
        currentItem?.count = currentItem!.count + 1
        updateQuantity()
        updatePrice()
    }
    
    @IBAction func minusButtonClicked(){
        currentItem?.count = currentItem!.count - 1
        updateQuantity()
        updatePrice()
    }
    
    func updateQuantity(){
        lblItemQuantity.text = "\(currentItem!.count)"
        NotificationCenter.default.post(name: Notification.Name(rawValue: "updateCartItem"), object: nil, userInfo: ["editedCartItem": currentItem!])
        
    }
    
    func updatePrice(){
        lblItemPrice.text = "Rs. \(String(format : "%.2f", currentItem!.cartItemPrice) )"
    }

}
