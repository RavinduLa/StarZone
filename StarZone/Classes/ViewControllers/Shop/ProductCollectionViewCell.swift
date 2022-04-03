//
//  ProductCollectionViewCell.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-03.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
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

extension UIImage {

    func imageResize (sizeChange:CGSize)-> UIImage{

        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen

        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }

}
