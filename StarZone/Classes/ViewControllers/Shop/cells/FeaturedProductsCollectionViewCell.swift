//
//  FeaturedProductsCollectionViewCell.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-11.
//

import UIKit

class FeaturedProductsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeaturedProductsCollectionViewCell"
    
    @IBOutlet weak var productNameLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var productImageView : UIImageView!
    @IBOutlet weak var btnAddToCart : UIButton!
    
    func setImage(){
        let imageSize = CGSize(width: 100, height: 100)
        var starZoneImage = UIImage(named: "StarZone Curved")
        starZoneImage = starZoneImage?.imageResize(sizeChange: imageSize)
        productImageView.image = starZoneImage
    }
    
}
