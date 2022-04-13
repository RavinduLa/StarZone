//
//  ProductSinglePageViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-04.
//

import UIKit

class ProductSinglePageViewController: UIViewController {
    
    @IBOutlet weak var txtCode: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var txtProdcutName: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblItemCount: UILabel!
    
    
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
        
        self.txtCode.text = self.seletedItem?.itemId
        self.txtProdcutName.text = self.seletedItem?.itemName
        self.txtDescription.text = self.seletedItem?.itemDescription
        self.txtPrice.text = "Rs.\(String(format : "%.2f",cvArgPrice))"
        updateCount()
        
        
        setImage()

        // Do any additional setup after loading the view.
    }
    
    func setImage(){
        
        //if the image is resized the memory consumption increases. Possible memory leak.
        
        let path = Bundle.main.path(forResource: "sample-image", ofType: "jpg")
        let starZoneImage = UIImage(contentsOfFile: path!)!
        //let starZoneImage = UIImage(named: "StarZone Curved")!
        self.imgProduct.image = starZoneImage
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
        
        let newCartItem = CartItem(product: addingItem, count: count)
        
        //Notification center posts the new cart item to ProductTabBarController
        NotificationCenter.default.post(name: Notification.Name(rawValue: "sendCartItemtoTabBarController"), object: nil, userInfo: ["itemObject": newCartItem])
        
        print("Sent notification from single view")
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

