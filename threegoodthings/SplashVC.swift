//
//  ViewController.swift
//  threegoodthings
//
//  Created by Steven Buchko on 7/10/17.
//  Copyright © 2017 Steven Buchko. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

let babyblue = UIColor(red: 0x4A, green: 0x90, blue: 0xE2)


class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = babyblue
        
        emailLogin.layer.cornerRadius = 25
        facebookLogin.layer.cornerRadius = 25
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("STEVEN: ID found in keychain")
            performSegue(withIdentifier: "goToMain", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("STEVEN: Unable to authenticate with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("STEVEN: User cancelled Facebook authentication")
            } else {
                print("STEVEN: Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                self.performSegue(withIdentifier: "goToMain", sender: nil)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("STEVEN: Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print("STEVEN: Successfully authenticated with Firebase")
                if let user = user {
                    KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                }
            }
        })
    }
    
    
    @IBOutlet weak var emailLogin: UIButton!

    @IBOutlet weak var facebookLogin: UIButton!
    
}

