//
//  ProductSinglePageViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-04.
//

import UIKit
import SDWebImage

class ProductSinglePageViewController: UIViewController {
    
    @IBOutlet weak var txtCode: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var txtProdcutName: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblItemCount: UILabel!
    @IBOutlet weak var lblRemainingQuantity: UILabel!
    
    weak var seletedItem : ProductItem?
    var count : Int = 1{
        //stop decrementing count below 1
        didSet{
            if count <= 0{
                count = 1
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cvArgPrice = self.seletedItem?.price  as! CVarArg
        
        self.txtCode.text = self.seletedItem?.code
        self.txtProdcutName.text = self.seletedItem?.itemName
        self.txtDescription.text = self.seletedItem?.itemDescription
        self.txtPrice.text = "Rs. \(String(format : "%.2f",cvArgPrice))"
        let remainingQuantity = self.seletedItem?.remainingQuantity ?? 1
        
        if remainingQuantity > 1{
            self.lblRemainingQuantity.text = "\(remainingQuantity) Units Available"
        }
        else if remainingQuantity == 1{
            self.lblRemainingQuantity.text = "\(remainingQuantity) Unit Available"
        }
        else{
            self.lblRemainingQuantity.text = "Not Available"
        }
        
        updateCount()
        
        
        //setImage()
        
        loadImageFromSDWebImage()
    }
    
    func setImage(){
        
        //if the image is resized the memory consumption increases. Possible memory leak.
        
        let path = Bundle.main.path(forResource: "sample-image", ofType: "jpg")
        let starZoneImage = UIImage(contentsOfFile: path!)!
        //let starZoneImage = UIImage(named: "StarZone Curved")!
        self.imgProduct.image = starZoneImage
    }
    
    //loads the image with caching using SDWebImage
    func loadImageFromSDWebImage(){
        imgProduct.sd_setImage(with: URL(string: seletedItem!.imageLink), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
    }
    
    @IBAction func decrementButtonClick(_ sender: Any) {
        print("Decrement button clicked")
        count = count - 1
        updateCount()
    }
    
    @IBAction func incrementButtonClick(_ sender: Any) {
        print("Increment button clicked")
        count = count + 1
        updateCount()
    }
    
    func updateCount(){
        self.lblItemCount.text = "\(count)"
    }
    
    @IBAction func addToCartButtonClick(_ sender: Any) {
        //using notification center to add the current item with count to cart
        let addingItem = self.seletedItem
        
        guard let addingItem = addingItem else {
            return
        }
        
        //check if remaining quantity is 0
        if addingItem.remainingQuantity <= 0{
            showItemNotAvailableAlert()
        }
        else{
            let newCartItem = CartItem(product: addingItem, count: count)
            
            //Notification center posts the new cart item to ProductTabBarController
            NotificationCenter.default.post(name: Notification.Name(rawValue: "sendCartItemtoTabBarController"), object: nil, userInfo: ["itemObject": newCartItem])
            
            showItemAddedAlert()
        }
        
        
    }
    
    func showItemAddedAlert(){
        let addedAlert = UIAlertController(title: "Item Added", message: "Your item has been added to cart", preferredStyle: UIAlertController.Style.alert)
        
        addedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action : UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(addedAlert, animated: true, completion: nil)
    }
    
    func showItemNotAvailableAlert(){
        let notAvailableAlert = UIAlertController(title: "Item not available", message: "This item is not available right now. Please check later or contact our sales team to get more info on arrival dates for stocks.", preferredStyle: UIAlertController.Style.alert)
        notAvailableAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action : UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(notAvailableAlert, animated: true, completion: nil)
    }
    
    func popSingleView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*override func viewWillDisappear(_ animated: Bool) {
        print("Popping product single view page")
        
        navigationController?.popViewController(animated: true)
        print("Popped product single view page")
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

