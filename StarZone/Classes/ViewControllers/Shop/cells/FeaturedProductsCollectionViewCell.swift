//
//  FeaturedProductsCollectionViewCell.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-14.
//

import UIKit

class FeaturedProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblProductName : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var image : UIImageView!
    @IBOutlet weak var btnAddToCart : UIButton!
    
    weak var delegate : FeaturedProductCollectionViewDelegate?
    static let identifier = "FeaturedProductsCollectionViewCell"
    var product : ProductItem?
    
    static func nib() -> UINib{
        return UINib(nibName: "FeaturedProductsCollectionViewCell", bundle: nil)
    }
    
    
    @IBAction func addToCartButonClick(){
        self.delegate?.productCellSelected(self.product!, buttonTapped: self.btnAddToCart)
    }
    
    public func configure(with product : ProductItem){
        self.product = product
        self.lblProductName.text = product.itemName
        self.lblPrice.text = "Rs. \(String(format : "%.2f",product.price))"
        setImage()
    }
    
    func setImage(){
        let imageSize = CGSize(width: 150, height: 121)
        var starZoneImage = UIImage(named: "sample image")
        starZoneImage = starZoneImage?.imageResize(sizeChange: imageSize)
        image.image = starZoneImage
    }
    
}
