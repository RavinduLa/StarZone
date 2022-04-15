//
//  TBHomeViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-10.
//

import UIKit
import FirebaseFirestore

class TBHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewItemSelectedDelegate, ViewAllProductsDelegate {
    
    
    
    @IBOutlet weak var table  : UITableView!
    
    let reuseIdentifierFeatured = "featuredCell"
    let reuseIdentifierNew = "newCell"
    // also enter this string as the cell identifier in the storyboard
    //var items = ["1", "2", "3", "4", "5", "6"]
    
    
    let db = Firestore.firestore()
    
    
    var featuredProductList : [ProductItem] = [ProductItem]()
    var newProductList : [ProductItem] = [ProductItem]()
    var selectedItem : ProductItem?
    var featuredCollectionViewHeight : CGFloat?
    var currentTableCell : ProductTableViewCell?
    
    func setupSampleData(){
        /*let productItem1 = ProductItem(id: "1", name: "Display",description: "Description of diplay", imageLink: "dfdsfs", price: 78000.00, isFeatured: true, isNew: false)
        let productItem2 = ProductItem(id: "2", name: "Mouse",description: "Description of Mouse", imageLink: "dfdsfs", price: 5000.00, isFeatured: true, isNew: false)
        let productItem3 = ProductItem(id: "3", name: "Keyboard",description: "Description of Keyboard", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false)
        let productItem4 = ProductItem(id: "4", name: "Power bank",description: "Description of Power bank", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false)
        let productItem5 = ProductItem(id: "5", name: "Remote",description: "Description of Remote", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false)
        let productItem6 = ProductItem(id: "6", name: "Book",description: "Description of Book", imageLink: "dfdsfs", price: 12000.00, isFeatured: true, isNew: false)
        
        
        
        let productItem7 = ProductItem(id: "7", name: "Display J",description: "Description of didplay J", imageLink: "dfdsfs", price: 78000.00, isFeatured: false, isNew: true)
        let productItem8 = ProductItem(id: "8", name: "Mouse J",description: "Description of Mouse J", imageLink: "dfdsfs", price: 5000.00, isFeatured: false, isNew: true)
        let productItem9 = ProductItem(id: "9", name: "Keyboard J",description: "Description of Keyboard J", imageLink: "dfdsfs", price: 12000.00, isFeatured: false, isNew: true)
        let productItem10 = ProductItem(id: "10", name: "Power bank J",description: "Description of Power bank J", imageLink: "dfdsfs", price: 12000.00, isFeatured: false, isNew: true)
        let productItem11 = ProductItem(id: "11", name: "Remote J",description: "Description of Remote J", imageLink: "dfdsfs", price: 12000.00, isFeatured: false, isNew: true)
        let productItem12 = ProductItem(id: "12", name: "Book J",description: "Description of Book J", imageLink: "dfdsfs", price: 12000.00, isFeatured: false, isNew: true)
        
        */
        
        //featuredProductList.append(contentsOf: [productItem1,productItem2,productItem3,productItem4, productItem5, productItem6])
        //newProductList.append(contentsOf: [productItem7,productItem8,productItem9,productItem10, productItem11, productItem12])
        
        
        //get data from firebase service
        self.featuredProductList = ProductItemsLists.featuredProductList
        self.newProductList = ProductItemsLists.newProductList
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        table.register(ProductTableViewCell.nib(), forCellReuseIdentifier: ProductTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        //table.rowHeight = UITableView.automaticDimension
        //table.estimatedRowHeight = 600
        
        
        loadProducts()
        
        table.reloadData()
        
        //setupSampleData()
        
        if featuredProductList.isEmpty{
            print("TBHome featured product list empty")
        }
        for item in featuredProductList{
            print("IN view did load in TBHome")
            print("Featured product item name : \(item.itemName)")
        }
        
    }
    
    //load all products from firestore
    func loadProducts(){
        db.collection("products").getDocuments { snapshot, error in
            if error != nil{
                print("Error getting products")
            }
            else{
                if let snapshot = snapshot{
                    
                    for doc in snapshot.documents{
                        let productItem : ProductItem = ProductItem(id: doc.documentID, name: doc["itemName"] as? String ?? "name", description: doc["itemDescription"] as? String ?? "desc", imageLink: doc["imageLink"] as? String ?? "link", price: doc["price"] as? Double ?? 0.00, isFeatured: doc["isFeatured"] as? Bool ?? false, isNew: doc["isNew"] as? Bool ?? false, code: doc["code"] as? String ?? "00")
                        if productItem.isFeatured{
                            self.featuredProductList.append(productItem)
                        }
                        else if productItem.isNew{
                            self.newProductList.append(productItem)
                        }
                        else{
                            print("\(productItem.itemName) is not a featured nor new product. Discarding...")
                        }
                    }
                    
                    self.table.reloadData()
                    
                    
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = table.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        
        if indexPath.row == 0{
            print("Index Path \(indexPath.row)")
            //set the currently going table cell
            self.currentTableCell = cell
            cell.configure(with: featuredProductList)
            
            
            
            cell.lblSectionHeader.text = "Featured Products"
        }
        else if indexPath.row == 1{
            print("Index Path \(indexPath.row)")
            //set the currently going table cell
            self.currentTableCell = cell
            cell.configure(with: newProductList)
            cell.lblSectionHeader.text = "New Products"
        }
        
        //self.featuredCollectionViewHeight = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
        
        //setting the delegate from table view
        cell.delegate = self
        cell.viewAllDelegate = self
        
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        cell.collectionView.reloadData()
        cell.collectionViewHeight.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
        
        return cell
    }
    
    
    func tableViewCollectionItemSelected(_ product: ProductItem) {
        self.selectedItem = product
        performSegue(withIdentifier: "gotoProductSingleView", sender: nil)
    }
    
    func navigateToViewAll(_ section: String) {
        print("Navigate to view all from delegate recieved")
        if section == "featured"{
            performSegue(withIdentifier: "gotoFeaturedProducts", sender: nil)
        }
        else if section == "new"{
            performSegue(withIdentifier: "gotoNewProducts", sender: nil)
        }
        else{
            print("View all section is invalid")
        }
    }
    
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.cellForRow(at: indexPath) as! ProductTableViewCell
        //print("Collection view height : \(self.featuredCollectionViewHeight)")
        return 1000.00
    }*/
    
    
    
    /*func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell 	as? ProductTableViewCell{
            cell.collectionView.tag = indexPath.section
            cell.collectionView.reloadData()
        }
    }*/
    
    
    
    
    //setup new products collection
    /*func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newProductList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierNew, for: indexPath as IndexPath) as! ProductCollectionViewCell
        let currentItem = newProductList[indexPath.row]
        cell.productNameLabel.text = "\(currentItem.itemName)"
        cell.priceLabel.text = "Rs.\(currentItem.price)"
        cell.setImage()
        return cell
    }*/
    
    

    
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
    
    //method for dismissing the Product Single View
    /*@IBAction func undwindToTbHomeView(unwindSegue : UIStoryboardSegue) {
        print("Unwiding segue for product single view")
    }*/

}

protocol ProductCollectionViewCellDelegate: AnyObject{
    func collectionViewCell(_ cell: UICollectionViewCell, buttonTapped : UIButton)
}

protocol TableViewItemSelectedDelegate: AnyObject{
    func tableViewCollectionItemSelected(_ product: ProductItem)
}

protocol ViewAllProductsDelegate : AnyObject{
    func navigateToViewAll(_ section : String)
}
