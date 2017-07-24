//
//  MainVC.swift
//  threegoodthings
//
//  Created by Steven Buchko on 7/23/17.
//  Copyright © 2017 Steven Buchko. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class MainVC: UIViewController {

    @IBOutlet weak var goodBtn: UIButton!
    @IBOutlet weak var goodInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = babyblue
        goodBtn.layer.cornerRadius = 25
        
        // Make placeholder text for goodInput white
        let goodStr = NSAttributedString(string: "I was happy when...", attributes: [NSForegroundColorAttributeName:UIColor.white])
        goodInput.attributedPlaceholder = goodStr
        
        // Add bottom border email input
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: goodInput.frame.size.height - width, width:  goodInput.frame.size.width + 50, height: goodInput.frame.size.height)
        
        border.borderWidth = width
        goodInput.layer.addSublayer(border)
        goodInput.layer.masksToBounds = true
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

    @IBAction func signOutTapped(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSplash", sender: nil)
    }
}
