//
//  Product3CollectionViewCell.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-11.
//

import UIKit

class Product3CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productName : UILabel!
    @IBOutlet weak var price : UILabel!
    @IBOutlet weak var productImageView : UIImageView!
    @IBOutlet weak var btnAddToCart : UIButton!
    
    weak var delegate : ProductCollectionViewCellDelegate?
    
    static let identifier = "Product3CollectionViewCell"
    var product : ProductItem?
    
    static func nib() -> UINib{
        return UINib(nibName: "Product3CollectionViewCell", bundle: nil)
    }
    
    public func configure(with product : ProductItem){
        self.product = product
        self.productName.text = product.itemName
        self.price.text = "Rs. \(String(format : "%.2f",product.price))"
        setImage()
    }
    
    func setImage(){
        let imageSize = CGSize(width: 150, height: 121)
        var starZoneImage = UIImage(named: "sample image")
        starZoneImage = starZoneImage?.imageResize(sizeChange: imageSize)
        productImageView.image = starZoneImage
    }
    
    //method called when tapping the add to cart button
    @IBAction func btnAddToCartClick(_ sender: Any) {
        self.delegate?.collectionViewCell(self, buttonTapped: btnAddToCart)
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
