//
//  LoginViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-01.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btnForgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnForgotPasswordClick(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoForgotPassword", sender: self)
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
