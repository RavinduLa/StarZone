//
//  ProductHomeViewController-prev.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-03.
//

import UIKit

class ProductHomeViewController_prev: UIViewController  , UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var productsViewLeading: NSLayoutConstraint!
    @IBOutlet weak var productsViewTrailing: NSLayoutConstraint!
    
    var menuOut = false
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4", "5", "6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //the drawer is controlled here
    /*@IBAction func btnMenuClick(_ sender: Any) {
        
        if menuOut == false{
            productsViewLeading.constant = 150
            productsViewTrailing.constant = -150
            menuOut = true
        }
        else{
            productsViewLeading.constant = 0
            productsViewTrailing.constant = 0
            menuOut = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }){
            (animationComplete) in
            print("Hamburger menu animation complete")
        }
    }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ProductCollectionViewCell
        cell.productNameLabel.text = "Item \(self.items[indexPath.row])"
        cell.priceLabel.text = "Rs.2000.00"
        cell.setImage()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell \(indexPath.item)")
        //self.performSegue(withIdentifier: "gotoProductPage", sender: self)
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
