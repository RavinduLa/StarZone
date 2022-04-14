//
//  AllNewProductsViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-14.
//

import UIKit

class AllNewProductsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NewProductCollectionViewDelegate {
    
    @IBOutlet weak var newProductsCollectionView: UICollectionView!
    
    var newProductList : [ProductItem] = [ProductItem]()
    var selectedItem : ProductItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newProductsCollectionView.delegate = self
        newProductsCollectionView.dataSource = self
        setupSampleData()
    }
    
    func setupSampleData(){
        let productItem7 = ProductItem(id: "7", name: "Display J", description: "Description of diplay", price: 78000.00)
        let productItem8 = ProductItem(id: "8", name: "Mouse", description: "Description of mouse", price: 5000.00)
        let productItem9 = ProductItem(id: "9", name: "Keyboard", description: "Description of keyboard", price: 12000.00)
        let productItem10 = ProductItem(id: "10", name: "Power bank", description: "Description of Power bank", price: 12000.00)
        let productItem11 = ProductItem(id: "11", name: "Remote", description: "Description of Remote", price: 12000.00)
        let productItem12 = ProductItem(id: "12", name: "Book", description: "Description of Book", price: 12000.00)
        
        newProductList.append(contentsOf: [productItem7,productItem8,productItem9,productItem10, productItem11, productItem12])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newProductList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newProductsCollectionView.dequeueReusableCell(withReuseIdentifier: NewProductsCollectionViewCell.identifier, for: indexPath) as! NewProductsCollectionViewCell
        cell.configure(with: newProductList[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 166, height: 275)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }*/
    
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

protocol NewProductCollectionViewDelegate :AnyObject{
    func productCellSelected(_ product : ProductItem, buttonTapped : UIButton)
}
