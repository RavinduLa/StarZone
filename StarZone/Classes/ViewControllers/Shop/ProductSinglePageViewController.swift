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
    
    
    var seletedItem : ProductItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let strPrice = String(format: "%.2f", self.seletedItem?.price as! CVarArg)
        
        self.txtCode.text = self.seletedItem?.itemId
        self.txtProdcutName.text = self.seletedItem?.itemName
        self.txtDescription.text = self.seletedItem?.itemDescription
        self.txtPrice.text = "Rs.\(strPrice)"
        
        setImage()

        // Do any additional setup after loading the view.
    }
    
    func setImage(){
        let imageSize = CGSize(width: 300, height: 300)
        var starZoneImage = UIImage(named: "StarZone Curved")
        starZoneImage = starZoneImage?.imageResize(sizeChange: imageSize)
        imgProduct.image = starZoneImage
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

