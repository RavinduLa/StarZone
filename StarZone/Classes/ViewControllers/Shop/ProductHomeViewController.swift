//
//  ProductHomeViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-03.
//

import UIKit

class ProductHomeViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    
    var menuOut = false
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    //var items = ["1", "2", "3", "4", "5", "6"]
    
    var productList : [ProductItem] = [ProductItem]()
    var selectedItem : ProductItem?
    
    
    func setupSampleData(){
        
        let productItem1 = ProductItem(id: "1", name: "Display",description: "Description of diplay", imageLink: "dfdsfs", price: 78000.00, isFeatured: true, isNew: false)
        let productItem2 = ProductItem(id: "2", name: "Mouse",description: "Description of Mouse", imageLink: "dfdsfs", price: 5000.00, isFeatured: true, isNew: false)
        let productItem3 = ProductItem(id: "3", name: "Keyboard",description: "Description of Keyboard", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false)
        let productItem4 = ProductItem(id: "4", name: "Power bank",description: "Description of Power bank", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false)
        let productItem5 = ProductItem(id: "5", name: "Remote",description: "Description of Remote", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false)
        let productItem6 = ProductItem(id: "6", name: "Book",description: "Description of Book", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false)
        
        
        productList.append(contentsOf: [productItem1,productItem2,productItem3,productItem4, productItem5, productItem6])
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ProductCollectionViewCell
        let currentItem = productList[indexPath.row]
        cell.productNameLabel.text = "\(currentItem.itemName)"
        cell.priceLabel.text = "Rs.\(currentItem.price)"
        cell.setImage()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell \(indexPath.item)")
        self.selectedItem = self.productList[indexPath.row]
        self.performSegue(withIdentifier: "gotoProductSingleView", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSampleData()

        // Do any additional setup after loading the view.
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
