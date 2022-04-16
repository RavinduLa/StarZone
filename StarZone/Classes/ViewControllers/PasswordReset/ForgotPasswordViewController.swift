//
//  ForgotPasswordViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-02.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        print("Back button clicked")
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSendResetLinkClick(_ sender: Any) {
        let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isValidEmail(email) == false{
            showAlert(title: "Email Invalid", message: "Please enter a valid email")
        }
        else{
            SVProgressHUD.show()
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error != nil{
                    SVProgressHUD.dismiss()
                    print("Error in password resetting. Code : \(error!._code), Localized message : \(error!.localizedDescription)")
                }
                else{
                    print("Email sent")
                    SVProgressHUD.dismiss()
                    self.showAlert(title: "Check your mail", message: "A password reset link has been emailed to your email, \(email). Visit the link in the email to reset your password.")
                }
               
            }
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        
        if email.isEmpty{
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showAlert(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action : UIAlertAction) in
            //nothing here
        }))
        present(alert, animated: true, completion: nil)
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
