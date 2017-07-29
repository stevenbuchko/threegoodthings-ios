//
//  SignupVC.swift
//  threegoodthings
//
//  Created by Steven Buchko on 7/17/17.
//  Copyright © 2017 Steven Buchko. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = babyblue
        
        signUpBtn.layer.cornerRadius = 25
        
        let nameStr = NSAttributedString(string: "Name", attributes: [NSForegroundColorAttributeName:UIColor.white])
        let emailStr = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName:UIColor.white])
        let passwordStr = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName:UIColor.white])
        
        nameInput.attributedPlaceholder = nameStr
        emailInput.attributedPlaceholder = emailStr
        passwordInput.attributedPlaceholder = passwordStr
        
        // Add bottom border to name input
        let nameborder = CALayer()
        let namewidth = CGFloat(1.0)
        nameborder.borderColor = UIColor.white.cgColor
        nameborder.frame = CGRect(x: 0, y: nameInput.frame.size.height - namewidth, width:  nameInput.frame.size.width + 50, height: nameInput.frame.size.height)
        
        nameborder.borderWidth = namewidth
        nameInput.layer.addSublayer(nameborder)
        nameInput.layer.masksToBounds = true
        
        // Add bottom border email input
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: emailInput.frame.size.height - width, width:  emailInput.frame.size.width + 50, height: emailInput.frame.size.height)
        
        border.borderWidth = width
        emailInput.layer.addSublayer(border)
        emailInput.layer.masksToBounds = true
        
        // Add bottom border to password input
        let passborder = CALayer()
        let passwidth = CGFloat(1.0)
        passborder.borderColor = UIColor.white.cgColor
        passborder.frame = CGRect(x: 0, y: passwordInput.frame.size.height - passwidth, width:  passwordInput.frame.size.width + 50, height: passwordInput.frame.size.height)
        
        passborder.borderWidth = passwidth
        passwordInput.layer.addSublayer(passborder)
        passwordInput.layer.masksToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        if let email = emailInput.text, let pwd = passwordInput.text {
            Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                if error != nil {
                    print("STEVEN: Unable to authenticate with Firebase using email.")
                } else {
                    print("STEVEN: Successfully authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        DataService.ds.createFirebaseDBUSer(uid: user.uid, userData: userData)
                        KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                    }
                    self.performSegue(withIdentifier: "goToMain", sender: nil)
                }
            })
        }
    }
}
