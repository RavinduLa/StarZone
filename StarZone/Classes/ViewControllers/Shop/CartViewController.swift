//
//  CartViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-10.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    }
    
    //reload the data of table view to get any newly added cart items
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
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
        cell.lblItemPrice.text = "\(currentItem.cartItemPrice)"
        cell.lblItemQuantity.text = "\(currentItem.count)"
        return cell
    }
    
    //observer to receive new cart items from tabbar controller
    func setupNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.addCartItemByNotification(notification:)), name: Notification.Name(rawValue: "addNewCartItem"), object: nil)
    }
    
    //once a new item is received via notification center add it to cart item list.
    @objc func addCartItemByNotification(notification : Notification){
        if let userInfo = notification.userInfo{
            print("recieved in cart")
            let newCartItem = userInfo["itemObject"] as! CartItem
            self.cartItemList.append(newCartItem)

        }
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

