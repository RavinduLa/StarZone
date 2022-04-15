//
//  LoginViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-01.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }
    
    func setupElements(){
        lblError.isHidden = true
    }
    
    @IBAction func btnForgotPasswordClick(_ sender: Any) {
        //self.performSegue(withIdentifier: "gotoForgotPassword", sender: self)
        transitionToForgotPassword()
    }
    
    @IBAction func btnLoginClick(_ sender: Any) {
        //self.performSegue(withIdentifier: "gotoProductHome", sender: self)
        //self.performSegue(withIdentifier: "gotoTabBar", sender: self)
        
        let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                
                SVProgressHUD.dismiss()
                //could not sign in
                //error code 17009 password incorrect?
                var errorMessage = ""
                
                print("Firebase error : \(error!._code)")
                print("Loclalized firebase error : \(error!.localizedDescription)")
                let errorCode = error!._code
                switch errorCode{
                case 17008:
                    errorMessage = "Invalid Email"
                case 17009:
                    errorMessage = "Wrong password"
                case 17010:
                    errorMessage = "Too many failed attempts. Try again later."
                case 17011:
                    errorMessage = "Wrong Email"
                default:
                    errorMessage = "Oops ! there was some error"
                    print("Other error")
                }
                
                //self.lblError.text = error!.localizedDescription
                self.lblError.text = errorMessage
                self.lblError.isHidden = false
            }
            else{
                SVProgressHUD.dismiss()
                print("Sign in Successful")
                self.transitionToTabBarHome()
            }
        }
        
        
        
    }
    
    @IBAction func btnSignupClick(_ sender: Any) {
        transitionToSignup()
    }
    
    func transitionToSignup(){
        let signUpViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.signupViewController) as? SignupViewController
        view.window?.rootViewController = signUpViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    func transitionToTabBarHome(){
        let tabBarViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.tabBarViewController) as? ProductTabBarController
        
        let foregroundedScenes = UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }
        let window = foregroundedScenes.map { $0 as? UIWindowScene }.compactMap { $0 }.first?.windows.filter { $0.isKeyWindow }.first
        
        guard let uWindow = window else { return }
        uWindow.rootViewController = tabBarViewController
        UIView.transition(with: uWindow, duration: 0.3, options: [.transitionFlipFromRight], animations: {}, completion: nil)
        
        print("Transition to tab bar block complete")
        //view.window?.rootViewController = tabBarViewController
        //view.window?.makeKeyAndVisible()
    }
    
    func transitionToForgotPassword(){
        let forgotPasswordViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.StoryBoard.forgotPasswordViewController) as? ForgotPasswordViewController
        forgotPasswordViewController?.modalPresentationStyle = .fullScreen
        self.present(forgotPasswordViewController!, animated: true, completion: nil)
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
