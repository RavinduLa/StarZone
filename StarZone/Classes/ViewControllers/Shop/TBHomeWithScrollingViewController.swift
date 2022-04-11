//
//  TBHomeWithScrollingViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-11.
//

import UIKit

class TBHomeWithScrollingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var featuredProductsUIView: UIView!
    @IBOutlet weak var newProductsUIView: UIView!
    @IBOutlet weak var newProductsCollectionView: UICollectionView!
    @IBOutlet weak var featuredProductsCollectionView: UICollectionView!
    
    @IBOutlet weak var featuredProductsVIewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var newProductsViewHeightConstraint: NSLayoutConstraint!
    
    var featuredProductList : [ProductItem] = [ProductItem]()
    var newProductList : [ProductItem] = [ProductItem]()
    var selectedItem : ProductItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupSampleData()
        
        featuredProductsCollectionView.delegate = self
        featuredProductsCollectionView.dataSource = self
        
        newProductsCollectionView.delegate = self
        newProductsCollectionView.dataSource = self
        
        scrollView.contentSize = CGSize(width: 400, height: 2300)
        
    }
    
    /*override func updateViewConstraints() {
        featuredProductsVIewHeightConstraint.constant = featuredProductsCollectionView.contentSize.height
        newProductsViewHeightConstraint.constant = newProductsCollectionView.contentSize.height
        super.updateViewConstraints()
    }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.featuredProductsCollectionView{
            return featuredProductList.count
        }
        else if collectionView == self.newProductsCollectionView{
            return newProductList.count
        }
        else{
            print("Collection view not propoerly detected.")
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.featuredProductsCollectionView{
            let featuredProductsCell = featuredProductsCollectionView.dequeueReusableCell(withReuseIdentifier: FeaturedProductsCollectionViewCell.identifier, for: indexPath) as! FeaturedProductsCollectionViewCell
            let currentFeaturedItem = featuredProductList[indexPath.row]
            featuredProductsCell.productNameLabel.text = currentFeaturedItem.itemName
            featuredProductsCell.priceLabel.text = String(currentFeaturedItem.price)
            featuredProductsCell.setImage()
            
            return featuredProductsCell
        }
        else if collectionView == self.newProductsCollectionView{
            let newProductsCell = newProductsCollectionView.dequeueReusableCell(withReuseIdentifier: NewProductsCollectionViewCell.identifier, for: indexPath) as! NewProductsCollectionViewCell
            let currentNewItem = newProductList[indexPath.row]
            newProductsCell.productNameLabel.text = currentNewItem.itemName
            newProductsCell.priceLabel.text = String(currentNewItem.price)
            newProductsCell.setImage()
            
            return newProductsCell
        }
        else{
            print("Collection view not propoerly detected.")
        }
        
        return UICollectionViewCell()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //configureSizes()
    }
    
    fileprivate func configureSizes() {
        let metrics = ["elementWidth" : self.view.frame.size.width - 20, "imageHeight" : 220]
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v1(imageHeight)]-10-[v2]-10-|", options: [], metrics: metrics, views: ["v1" : featuredProductsCollectionView, "v2" : newProductsCollectionView]))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v1(elementWidth)]-10-|", options: [], metrics: metrics, views: ["v1" : featuredProductsCollectionView]))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v2(elementWidth)]-10-|", options: [], metrics: metrics, views: ["v2" : newProductsCollectionView]))
    }
    
    
    
    func setupSampleData(){
        let productItem1 = ProductItem(id: "1", name: "Display", description: "Description of diplay", price: 78000.00)
        let productItem2 = ProductItem(id: "2", name: "Mouse", description: "Description of mouse", price: 5000.00)
        let productItem3 = ProductItem(id: "3", name: "Keyboard", description: "Description of keyboard", price: 12000.00)
        let productItem4 = ProductItem(id: "4", name: "Power bank", description: "Description of Power bank", price: 12000.00)
        let productItem5 = ProductItem(id: "5", name: "Remote", description: "Description of Remote", price: 12000.00)
        let productItem6 = ProductItem(id: "6", name: "Book", description: "Description of Book", price: 12000.00)
        
        let productItem7 = ProductItem(id: "7", name: "Display", description: "Description of diplay", price: 78000.00)
        let productItem8 = ProductItem(id: "8", name: "Mouse", description: "Description of mouse", price: 5000.00)
        let productItem9 = ProductItem(id: "9", name: "Keyboard", description: "Description of keyboard", price: 12000.00)
        let productItem10 = ProductItem(id: "10", name: "Power bank", description: "Description of Power bank", price: 12000.00)
        let productItem11 = ProductItem(id: "11", name: "Remote", description: "Description of Remote", price: 12000.00)
        let productItem12 = ProductItem(id: "12", name: "Book", description: "Description of Book", price: 12000.00)
        
        featuredProductList.append(contentsOf: [productItem1,productItem2,productItem3,productItem4, productItem5, productItem6])
        newProductList.append(contentsOf: [productItem7,productItem8,productItem9,productItem10, productItem11, productItem12])
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
