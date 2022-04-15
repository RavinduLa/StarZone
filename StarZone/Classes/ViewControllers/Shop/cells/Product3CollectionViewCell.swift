//
//  Product3CollectionViewCell.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-11.
//

import UIKit
import SDWebImage

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
        
        
        //setImage()
        //fetchImage()
        
        
        
        loadImageFromSDWebImage()
        
    }
    
    func clearSDWebImageCache(){
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk(onCompletion: nil)
    }
    
    func loadImageFromSDWebImage(){
        productImageView.sd_setImage(with: URL(string: product!.imageLink), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
    }
    
    func setImage(){
        let imageSize = CGSize(width: 150, height: 121)
        var starZoneImage = UIImage(named: "sample image")
        starZoneImage = starZoneImage?.imageResize(sizeChange: imageSize)
        productImageView.image = starZoneImage
    }
    
    //methodt to fetch the image manually
    func fetchImage(){
        guard let url = URL(string: product!.imageLink) else{
            return
        }
        
        let getDataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.productImageView.image = image
            }

        }
        
        getDataTask.resume()
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
