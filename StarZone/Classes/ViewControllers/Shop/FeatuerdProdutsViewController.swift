//
//  FeatuerdProdutsViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-02.
//

import UIKit

class FeatuerdProdutsViewController: UIViewController {

    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var productsViewLeading: NSLayoutConstraint!
    @IBOutlet weak var productsViewTrailing: NSLayoutConstraint!
    
    var menuOut = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnMenuClick(_ sender: Any) {
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
