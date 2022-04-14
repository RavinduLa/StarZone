//
//  AllFeaturedProductsViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-14.
//

import UIKit

class AllFeaturedProductsViewController: UIViewController, FeaturedProductCollectionViewDelegate {

    @IBOutlet weak var featuredProductsCollectionView: UICollectionView!
    
    var featuredProductList : [ProductItem] = [ProductItem]()
    var selectedItem : ProductItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func setupSampleData(){
        let productItem1 = ProductItem(id: "1", name: "Display", description: "Description of diplay", price: 78000.00)
        let productItem2 = ProductItem(id: "2", name: "Mouse", description: "Description of mouse", price: 5000.00)
        let productItem3 = ProductItem(id: "3", name: "Keyboard", description: "Description of keyboard", price: 12000.00)
        let productItem4 = ProductItem(id: "4", name: "Power bank", description: "Description of Power bank", price: 12000.00)
        let productItem5 = ProductItem(id: "5", name: "Remote", description: "Description of Remote", price: 12000.00)
        let productItem6 = ProductItem(id: "6", name: "Book", description: "Description of Book", price: 12000.00)
        
        let productItem13 = ProductItem(id: "13", name: "Banana Flower", description: "Banana Flower Description", price: 12000.00)
        
        featuredProductList.append(contentsOf: [productItem1,productItem2,productItem3,productItem4, productItem5, productItem6, productItem13])
    }
    
    func productCellSelected(_ product: ProductItem, buttonTapped: UIButton) {
        self.selectedItem = product
        performSegue(withIdentifier: "gotoProductSingleView", sender: nil)
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
