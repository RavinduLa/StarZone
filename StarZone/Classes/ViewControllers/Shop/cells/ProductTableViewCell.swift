//
//  ProductTableViewCell.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-11.
//

import UIKit

class ProductTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    

    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lblSectionHeader: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    //var featuredProductList : [ProductItem] = [ProductItem]()
    //var newProductList : [ProductItem] = [ProductItem]()
    
    var productList : [ProductItem] = [ProductItem]()
    
    
    static let identifier = "ProductTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "ProductTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(Product3CollectionViewCell.nib(), forCellWithReuseIdentifier: Product3CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Product3CollectionViewCell.identifier, for: indexPath) as! Product3CollectionViewCell
        cell.configure(with: productList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 166, height: 275)
    }
    
    public func configure(with products : [ProductItem]){
        print("Configuring table view")
        self.productList = products
        collectionView.reloadData()
    }
    
}
