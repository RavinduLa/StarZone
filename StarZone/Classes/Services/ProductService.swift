//
//  ProductService.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-15.
//

import Foundation
import FirebaseFirestore

class ProductService{
    
    let db = Firestore.firestore()
    var featuredProductList : [ProductItem] = [ProductItem]()
    var newProductList : [ProductItem] = [ProductItem]()
    
    func initializeProducData(){
        getAllServices()
        setFeaturedProducts()
        setNewProducts()
    }
    
    func setFeaturedProducts(){
        ProductItemsLists.featuredProductList = featuredProductList
    }
    
    func setNewProducts(){
        ProductItemsLists.newProductList = newProductList
    }
    
     func getAllServices(){
        db.collection("products").getDocuments { snapshot, error in
            if error != nil{
                print("Error getting products")
            }
            else{
                if let snapshot = snapshot{
                    for doc in snapshot.documents{
                        let productItem : ProductItem = ProductItem(id: doc.documentID, name: doc["itemName"] as? String ?? "name", description: doc["itemDescription"] as? String ?? "desc", imageLink: doc["imageLink"] as? String ?? "link", price: doc["price"] as? Double ?? 0.00, isFeatured: doc["isFeatured"] as? Bool ?? false, isNew: doc["isNew"] as? Bool ?? false)
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

                }
            }
        }
    }
}
