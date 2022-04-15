//
//  AllFeaturedProductsViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-14.
//

import UIKit

class AllFeaturedProductsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FeaturedProductCollectionViewDelegate {
    
    

    @IBOutlet weak var featuredProductsCollectionView: UICollectionView!
    
    var featuredProductList : [ProductItem] = [ProductItem]()
    var selectedItem : ProductItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //featuredProductsCollectionView.register(FeaturedProductsCollectionViewCell.nib(), forCellWithReuseIdentifier: FeaturedProductsCollectionViewCell.identifier)
        featuredProductsCollectionView.delegate = self
        featuredProductsCollectionView.dataSource = self

        //setupSampleData()
    }
    
    
    func setupSampleData(){
        
        let productItem1 = ProductItem(id: "1", name: "Display",description: "Description of diplay", imageLink: "dfdsfs", price: 78000.00, isFeatured: true, isNew: false, code: "0001")
        let productItem2 = ProductItem(id: "2", name: "Mouse",description: "Description of Mouse", imageLink: "dfdsfs", price: 5000.00, isFeatured: true, isNew: false, code: "0001")
        let productItem3 = ProductItem(id: "3", name: "Keyboard",description: "Description of Keyboard", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false, code: "0001")
        let productItem4 = ProductItem(id: "4", name: "Power bank",description: "Description of Power bank", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false, code: "0001")
        let productItem5 = ProductItem(id: "5", name: "Remote",description: "Description of Remote", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false, code: "0001")
        let productItem6 = ProductItem(id: "6", name: "Book",description: "Description of Book", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false, code: "0001")
        
        
        featuredProductList.append(contentsOf: [productItem1,productItem2,productItem3,productItem4, productItem5, productItem6])
    }
    
    func productCellSelected(_ product: ProductItem, buttonTapped: UIButton) {
        self.selectedItem = product
        performSegue(withIdentifier: "gotoProductSingleView", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredProductList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = featuredProductsCollectionView.dequeueReusableCell(withReuseIdentifier: FeaturedProductsCollectionViewCell.identifier, for: indexPath) as! FeaturedProductsCollectionViewCell
        cell.configure(with: featuredProductList[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 166, height: 275)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "gotoProductSingleView"{
            //add the selected item for the single page here
            let viewController = segue.destination as! ProductSinglePageViewController
            viewController.seletedItem = self.selectedItem
        }
    }

}

protocol FeaturedProductCollectionViewDelegate :AnyObject{
    func productCellSelected(_ product : ProductItem, buttonTapped : UIButton)
}
