//
//  SignupViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-01.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignupViewController: UIViewController {
    
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupElements()
    }
    
    func setupElements(){
        lblError.isHidden = true
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSignupClick(_ sender: Any) {
        
        //get the errors if any
        let error = validateFields()
        
        if error != nil{
            //show the error message
            showErrorMessage(error!)
        }
        else{
            //create ths user
            lblError.isHidden = true
            print("Creating user")
            
            //create cleaned versions of the data
            let fullName = txtFullName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password){ (result, error) in
                
                //check for errors
                if error != nil {
                    //if error is not nil there is an error
                    self.showErrorMessage("Error creating user")
                }
                else{
                    //user created successfully. Store the names
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["fullName" : fullName, "email" : email,
                                                               "uid" : result!.user.uid]) { (error) in
                        if error != nil{
                            //show error message
                            self.showErrorMessage("Firstname and last name not captured in the db")
                        }
                    }
                    
                    Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                        if error != nil{
                            print("Sending verification email failed")
                        }
                        else{
                            self.showLoginAlert(title: "Successful", message: "Your account has been created and a verification link has been sent to your email. Please click the link to verify your email and then login.")
                        }
                    })
                    
                    
                }
            }
        }
    }
    
    @IBAction func btnLoginClick(_ sender: Any) {
        transitionToLogin()
    }
    
    
    func showLoginAlert(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action : UIAlertAction) in
            self.logoutAndTransition()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func logoutAndTransition(){
        do{
            try Auth.auth().signOut()
            self.transitionToLanding()
        }catch let error{
            print("Logout error : \(error)")
        }
        
    }
    
    func transitionToLanding(){
        let landingViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.landingViewController) as? LandingViewController
        view.window?.rootViewController = landingViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToTabBarHome(){
        let tabBarViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.tabBarViewController) as? ProductTabBarController
        view.window?.rootViewController = tabBarViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToLogin(){
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.loginViewController) as? LoginViewController
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
    func validateFields() -> String?{
        //check that all the fields are filled
        if txtFullName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtConfirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill all the fields"
        }
        
        let cleanedEmail = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isValidEmail(cleanedEmail) == false{
            return "Please enter a valid email"
        }
    
        
       
        let cleanedPassword = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordLengthValid(cleanedPassword) == false{
            return "Password must be of lenght between 6 - 15"
        }
        
        //check if the passoword is secure
        if isPassWordValid(cleanedPassword) == false{
            return "Please make sure that your password contains both lower and upper case letters, a special character and a number"
        }
        
        
        let cleanedConfirmationPassword = txtConfirmPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //check if the 2 passwords match
        if cleanedPassword != cleanedConfirmationPassword{
            return "Passwords do not match"
        }
        
        
        
        return nil
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isPasswordLengthValid(_ password :String) -> Bool{
        if password.count >= 6 && password.count <= 15{
            return true
        }
        else{
            return false
        }
    }
    func isPassWordValid(_ password : String) -> Bool{
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$&*]).{6,15}$"
        //let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    func showErrorMessage(_ errorMessage : String){
        lblError.text = errorMessage
        lblError.isHidden = false
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
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
