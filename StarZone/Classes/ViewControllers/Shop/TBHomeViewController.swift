//
//  TBHomeViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-10.
//

import UIKit

class TBHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var table  : UITableView!
    
    let reuseIdentifierFeatured = "featuredCell"
    let reuseIdentifierNew = "newCell"
    // also enter this string as the cell identifier in the storyboard
    //var items = ["1", "2", "3", "4", "5", "6"]
    
    
    
    var featuredProductList : [ProductItem] = [ProductItem]()
    var newProductList : [ProductItem] = [ProductItem]()
    var selectedItem : ProductItem?
    var featuredCollectionViewHeight : CGFloat?
    
    func setupSampleData(){
        let productItem1 = ProductItem(id: "1", name: "Display", description: "Description of diplay", price: 78000.00)
        let productItem2 = ProductItem(id: "2", name: "Mouse", description: "Description of mouse", price: 5000.00)
        let productItem3 = ProductItem(id: "3", name: "Keyboard", description: "Description of keyboard", price: 12000.00)
        let productItem4 = ProductItem(id: "4", name: "Power bank", description: "Description of Power bank", price: 12000.00)
        let productItem5 = ProductItem(id: "5", name: "Remote", description: "Description of Remote", price: 12000.00)
        let productItem6 = ProductItem(id: "6", name: "Book", description: "Description of Book", price: 12000.00)
        
        let productItem7 = ProductItem(id: "7", name: "Display J", description: "Description of diplay", price: 78000.00)
        let productItem8 = ProductItem(id: "8", name: "Mouse", description: "Description of mouse", price: 5000.00)
        let productItem9 = ProductItem(id: "9", name: "Keyboard", description: "Description of keyboard", price: 12000.00)
        let productItem10 = ProductItem(id: "10", name: "Power bank", description: "Description of Power bank", price: 12000.00)
        let productItem11 = ProductItem(id: "11", name: "Remote", description: "Description of Remote", price: 12000.00)
        let productItem12 = ProductItem(id: "12", name: "Book", description: "Description of Book", price: 12000.00)
        
        let productItem13 = ProductItem(id: "13", name: "Banana Flower", description: "Banana Flower Description", price: 12000.00)
        
        featuredProductList.append(contentsOf: [productItem1,productItem2,productItem3,productItem4, productItem5, productItem6, productItem13])
        newProductList.append(contentsOf: [productItem7,productItem8,productItem9,productItem10, productItem11, productItem12])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        table.register(ProductTableViewCell.nib(), forCellReuseIdentifier: ProductTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        //table.rowHeight = UITableView.automaticDimension
        //table.estimatedRowHeight = 600
        table.reloadData()
        setupSampleData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = table.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        
        if indexPath.row == 0{
            print("Index Path \(indexPath.row)")
            cell.configure(with: featuredProductList)
            cell.lblSectionHeader.text = "Featured Products"
        }
        else if indexPath.row == 1{
            print("Index Path \(indexPath.row)")
            cell.configure(with: newProductList)
            cell.lblSectionHeader.text = "New Products"
        }
        
        
        //self.featuredCollectionViewHeight = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        cell.collectionView.reloadData()
        cell.collectionViewHeight.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
        
        return cell
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
