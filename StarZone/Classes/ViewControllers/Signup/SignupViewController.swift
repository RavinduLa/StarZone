//
//  SignupViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-01.
//

import UIKit

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
        }
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
