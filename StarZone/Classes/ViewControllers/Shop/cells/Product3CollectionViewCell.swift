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
    
    static let identifier = "Product3CollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "Product3CollectionViewCell", bundle: nil)
    }
    
    public func configure(with product : ProductItem){
        print("Configuring collection view")
        print("Product Name : \(product.itemName)")
        self.productName.text = product.itemName
        self.price.text = String(product.price)
        setImage()
    }
    
    func setImage(){
        print("Setting image")
        let imageSize = CGSize(width: 150, height: 121)
        var starZoneImage = UIImage(named: "sample image")
        starZoneImage = starZoneImage?.imageResize(sizeChange: imageSize)
        productImageView.image = starZoneImage
    }
    
    @IBAction func btnAddToCartClick(_ sender: Any) {
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
