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
    
    
    weak var seletedItem : ProductItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let strPrice = String(format: "%.2f", self.seletedItem?.price as! CVarArg)
        let cvArgPrice = self.seletedItem?.price  as! CVarArg
        
        self.txtCode.text = self.seletedItem?.itemId
        self.txtProdcutName.text = self.seletedItem?.itemName
        self.txtDescription.text = self.seletedItem?.itemDescription
        self.txtPrice.text = "Rs.\(String(format : "%.2f",cvArgPrice))"
        
        
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

