//
//  LoginViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-01.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }
    
    func setupElements(){
        lblError.isHidden = true
    }
    
    @IBAction func btnForgotPasswordClick(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoForgotPassword", sender: self)
    }
    
    @IBAction func btnLoginClick(_ sender: Any) {
        //self.performSegue(withIdentifier: "gotoProductHome", sender: self)
        self.performSegue(withIdentifier: "gotoTabBar", sender: self)
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
