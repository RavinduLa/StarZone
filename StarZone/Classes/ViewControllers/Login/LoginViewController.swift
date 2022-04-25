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
    @IBOutlet weak var btnToggleShowPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
        if self.txtPassword.isSecureTextEntry {
            btnToggleShowPassword.setTitle("Show Password", for: .normal)
        }
    }
    
    func setupElements(){
        lblError.isHidden = true
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
                if Auth.auth().currentUser?.isEmailVerified == false{
                    print("Email is not verified")
                    do{
                        try Auth.auth().signOut()
                    }catch let error{
                        print("Signout failed. Error : \(error)")
                    }
                    self.showEmailNotVerifiedAlert()
                }
                else{
                    self.transitionToTabBarHome()
                }
                
            }
        }
        
        
        
    }
    
    @IBAction func btnToggleShowPasswordClick(_ sender: Any) {
        self.txtPassword.isSecureTextEntry = !self.txtPassword.isSecureTextEntry
        
        if self.txtPassword.isSecureTextEntry{
            self.btnToggleShowPassword.setTitle("Show Password", for: .normal)
        }
        else{
            self.btnToggleShowPassword.setTitle("Hide Password", for: .normal)
        }
        
    }
    
    
    @IBAction func btnSignupClick(_ sender: Any) {
        transitionToSignup()
    }
    
    func showEmailNotVerifiedAlert(){
        
        let emailNotVerifiedAlert = UIAlertController(title: "Email Not Verified", message: "Please check your inbox and click the confirmation link and verify your account. If youd did not receive the verification email click resend.", preferredStyle: UIAlertController.Style.alert)
        
        emailNotVerifiedAlert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: { (action : UIAlertAction) in
            
        }))
        emailNotVerifiedAlert.addAction(UIAlertAction(title: "Resend", style: .default, handler: { (action : UIAlertAction) in
            //cancel logout
        }))
        present(emailNotVerifiedAlert, animated: true, completion: nil)
        
    }
    
    func showAlert(title: String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action : UIAlertAction) in
            
        }))
    }
    
    func resendVerificationLink(){
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if error != nil{
                print ("Error sending verification link")
                self.showAlert(title: "Could Not Send Verification Email", message: "This could be due to bad network connection. Try again later on contact our customer support")
            }
        })
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
    
    func transitionToAboutUs(){
        let aboutUsViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.StoryBoard.aboutUsViewController) as?
        AboutUsViewController
        //aboutUsViewController?.modalPresentationStyle = .fullScreen
        self.present(aboutUsViewController!, animated: true, completion: nil)
    }
    
    func transitionToTermsAndConditions(){
        let termsAndConditionsViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.StoryBoard.termsAndConditionsViewController) as?
        TermsAndConditionsViewController
        termsAndConditionsViewController?.modalPresentationStyle = .fullScreen
        self.present(termsAndConditionsViewController!, animated: true, completion: nil)
    }
    
    func transitionToPrivacy(){
        let privacyViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.StoryBoard.privacyViewController) as?
        PrivacyViewController
        privacyViewController?.modalPresentationStyle = .fullScreen
        self.present(privacyViewController!, animated: true, completion: nil)
    }
    
    
    @IBAction func btnAboutUsClick(_ sender: Any) {
        transitionToAboutUs()
    }
    
    @IBAction func btnTermsAndConditionsClick(_ sender: Any) {
        transitionToTermsAndConditions()
    }
    
    @IBAction func btnPrivacyClick(_ sender: Any) {
        transitionToPrivacy()
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

extension UITextField{
    fileprivate func setPasswordToggleImage(_ button : UIButton){
        if(isSecureTextEntry){
            button.setImage(UIImage(named: "ic_password_visible"), for: .normal)
        }else{
            button.setImage(UIImage(named: "ic_password_invisible"), for: .normal)
            
        }
    }
}
