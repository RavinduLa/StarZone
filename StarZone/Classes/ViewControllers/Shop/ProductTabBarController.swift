//
//  ProductTabBarController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-10.
//

import UIKit
import FirebaseFirestore

class ProductTabBarController: UITabBarController {
    
    
    //var tempItemList : [ProductItem] = [ProductItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //instantiate imutable ProductService type instance
        //let ps : ProductService = ProductService()
        //populate global variables with product data
        //ps.initializeProducData()
        
        
        // Observer is setup to receive cart item from Single view
        print("Running product tabbar controller view did load")
        setupNotificationObserver()
    }
    
    func setupNotificationObserver(){
        //receive new cart item from  single view controller
        NotificationCenter.default.addObserver(self, selector: #selector(self.receiveAndSendCartItemByNotification(notification:)), name: Notification.Name(rawValue: "sendCartItemtoTabBarController"), object: nil)
    }
    
    @objc func receiveAndSendCartItemByNotification(notification : Notification){
        if let userInfo = notification.userInfo{
            print("recieved in tab bar")
            let cartItem = userInfo["itemObject"] as! CartItem
            
            //once the new cart item is recieved send it to the CartViewController.
            NotificationCenter.default.post(name: Notification.Name(rawValue: "addNewCartItem"), object: nil, userInfo: ["itemObject": cartItem])
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
