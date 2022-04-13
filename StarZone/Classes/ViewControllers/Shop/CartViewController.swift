//
//  CartViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-10.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    

    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var cartItemList : [CartItem] = [CartItem]()
    
    required init(coder aCoder : NSCoder) {
        super.init(coder: aCoder)!
        
        //setup the observer to receive the cart item from tabbar controller.
        setupNotificationObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView.init()
        tableView.reloadData()
        updateTotalPrice()
    }
    
    //reload the data of table view to get any newly added cart items
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        updateTotalPrice()
    }
    
    func addItemToCart(item: ProductItem, count: Int) {
        print("Cart view add Item to cart got called")
        let newCartItem = CartItem(product: item, count: count)
        cartItemList.append(newCartItem)
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItemList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartTableCell") as! CartTableViewCell
        let currentItem = cartItemList[indexPath.row]
        cell.lblItemName.text = "\(currentItem.productItem.itemName)"
        cell.lblItemPrice.text = "Rs. \(String(format : "%.2f", currentItem.cartItemPrice))"
        cell.lblItemQuantity.text = "\(currentItem.count)"
        cell.currentItem = currentItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            //delete item here
            self.deleteItem(itemIndex: indexPath.row)
        }
        
        return [delete]
    }
    
    func deleteItem(itemIndex : Int){
        //create the alert for deletion
        let deleteAlert = UIAlertController(title: "Delete Item?", message: "Are you sure you want to delete this item ?", preferredStyle: UIAlertController.Style.alert)
        deleteAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {(action : UIAlertAction) in
            print("Handle delete logic here..")
            self.cartItemList.remove(at: itemIndex)
            self.tableView.reloadData()
            self.updateTotalPrice()
            
        }
                                           )
        )
        
        //add cancel button
        //cancel style makes text bold
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) in print("Handle cancel alert here")}))
        
        //present the alert
        present(deleteAlert, animated: true, completion: nil)
    }
    
    //observer to receive new cart items from tabbar controller
    func setupNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.addCartItemByNotification(notification:)), name: Notification.Name(rawValue: "addNewCartItem"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateCartItemByNotification(notification:)), name: Notification.Name(rawValue: "updateCartItem"), object: nil)
    }
    
    //once a new item is received via notification center add it to cart item list.
    @objc func addCartItemByNotification(notification : Notification){
        if let userInfo = notification.userInfo{
            print("recieved in cart")
            let newCartItem = userInfo["itemObject"] as! CartItem
            self.cartItemList.append(newCartItem)

        }
    }
    
    @objc func updateCartItemByNotification(notification : Notification){
        if let userInfo = notification.userInfo{
            let updatedCartItem = userInfo["editedCartItem"] as! CartItem
            self.cartItemList.first(where: {$0 == updatedCartItem})?.count = updatedCartItem.count
            updateTotalPrice()
        }
    }
    
    func updateTotalPrice(){
        
        var total : Double = 0.0
        for item in cartItemList{
            total = total + item.cartItemPrice
        }
        lblTotalPrice.text = "Rs. \(String(format : "%.2f", total))" 
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
