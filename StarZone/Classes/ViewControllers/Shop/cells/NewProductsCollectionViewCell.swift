//
//  NewProductsCollectionViewCell.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-14.
//

import UIKit
import SDWebImage

class NewProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblProductName : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var image : UIImageView!
    @IBOutlet weak var btnAddToCart : UIButton!
    
    weak var delegate : NewProductCollectionViewDelegate?
    static let identifier = "NewProductsCollectionViewCell"
    var product : ProductItem?
    
    static func nib() -> UINib{
        return UINib(nibName: "NewProductsCollectionViewCell", bundle: nil)
    }
    
    
    @IBAction func addToCartButonClick(){
        self.delegate?.productCellSelected(self.product!, buttonTapped: self.btnAddToCart)
    }
    
    public func configure(with product : ProductItem){
        self.product = product
        self.lblProductName.text = product.itemName
        self.lblPrice.text = "Rs. \(String(format : "%.2f",product.price))"
        
        //load image
        loadImageFromSDWebImage()
    }
    
    func setImage(){
        let imageSize = CGSize(width: 150, height: 121)
        var starZoneImage = UIImage(named: "sample image")
        starZoneImage = starZoneImage?.imageResize(sizeChange: imageSize)
        image.image = starZoneImage
    }
    
    //loads the image with caching using SDWebImage
    func loadImageFromSDWebImage(){
        image.sd_setImage(with: URL(string: product!.imageLink), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
    }
    
}
