//
//  MoreViewController.swift
//  StarZone
//
//  Created by Ravindu Wataketiya on 2022-04-10.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogoutClick(_ sender: Any) {
        showLogoutConfirmationAlert()
    }
    
    func handleLogout(){
        //let signoutAction = UIAlertAction(title: "Signout", style: .destructive) { (action) in
            do{
                
                print("Running signout action")
                SVProgressHUD.show()
                try Auth.auth().signOut()
                SVProgressHUD.dismiss()
                print("Signout complete")
                self.transitionToLanding()
                
                
            }catch let error{
                SVProgressHUD.dismiss()
                print("Signout failed")
                print("Error : \(error)")
            }
        }
        
    
    func showLogoutConfirmationAlert(){
        
        let logoutConfirmationAlert = UIAlertController(title: "Logout?", message: "Are you sure you want to logout ?", preferredStyle: UIAlertController.Style.alert)
        logoutConfirmationAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action : UIAlertAction) in
            //logout user
            self.handleLogout()
        }))
        logoutConfirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action : UIAlertAction) in
            //cancel logout
        }))
        present(logoutConfirmationAlert, animated: true, completion: nil)
        
    }
    
    func transitionToLanding(){
        let landingViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.landingViewController) as? LandingViewController
        
        let foregroundedScenes = UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }
        let window = foregroundedScenes.map { $0 as? UIWindowScene }.compactMap { $0 }.first?.windows.filter { $0.isKeyWindow }.first
        
        guard let uWindow = window else { return }
        uWindow.rootViewController = landingViewController
        UIView.transition(with: uWindow, duration: 0.3, options: [.transitionFlipFromRight], animations: {}, completion: nil)
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
