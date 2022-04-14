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
    static let identifier = "featuredProductCollectionViewCell"
    var product : ProductItem?
    
    
    @IBAction func addToCartButonClick(){
        self.delegate?.productCellSelected(self.product!, buttonTapped: self.btnAddToCart)
    }
    
}
