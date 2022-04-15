//
//  LandingViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-01.
//

import UIKit
import FirebaseAuth

class LandingViewController: UIViewController {

    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //check whether the user is logged in and if yes redirect
        checkLoggedInuserStatus()
    }
    
    @IBAction func btnSignupClick(_ sender: Any) {
        //self.performSegue(withIdentifier: "gotoSignup", sender: self)
        transitionToSignUp()
    }
    
    @IBAction func btnLoginClick(_ sender: Any) {
        //self.performSegue(withIdentifier: "gotoLogin", sender: self)
        transitionToLogin()
    }
    
    fileprivate func checkLoggedInuserStatus(){
        if Auth.auth().currentUser != nil{
            print("Current user is not nil")
            /*DispatchQueue.main.async {
                let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.tabBarViewController) as? ProductTabBarController
                let tabBarNavigationController = UINavigationController(rootViewController: tabBarViewController!)
                tabBarNavigationController.modalPresentationStyle = .fullScreen
                self.present(tabBarNavigationController, animated: true, completion: nil)
                return
            }*/
            transitionToTabBar()
        }
        else{
            print("Current user is nil")
        }
    }
    
    
    func transitionToSignUp(){
        let signupViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.StoryBoard.signupViewController) as?
        SignupViewController
        signupViewController?.modalPresentationStyle = .fullScreen
        self.present(signupViewController!, animated: true, completion: nil)
        
    }
    
    func transitionToLogin(){
        let loginViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.StoryBoard.loginViewController) as? LoginViewController
        loginViewController?.modalPresentationStyle = .fullScreen
        self.present(loginViewController!, animated: true, completion: nil)
        //self.navigationController?.pushViewController(loginViewController!, animated: true)
    }
    
    func transitionToTabBar(){
        let tabBarController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.StoryBoard.tabBarViewController) as? ProductTabBarController
        tabBarController?.modalPresentationStyle = .fullScreen
        self.present(tabBarController!, animated: true, completion: nil)
        //self.navigationController?.pushViewController(loginViewController!, animated: true)
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
