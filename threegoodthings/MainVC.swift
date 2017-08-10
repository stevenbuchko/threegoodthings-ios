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
    @IBOutlet weak var goodCounter: UILabel!
    
    var posts = [Post]()
    var counter = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateCounter()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = babyblue
        goodBtn.layer.cornerRadius = 25
        
        //ui set up for goodCounter
        goodCounter.backgroundColor = UIColor.white
        goodCounter.layer.cornerRadius = goodCounter.frame.width/2
        goodCounter.clipsToBounds = true
        goodCounter.textColor = UIColor(red: 85/255.0, green: 149/255.0, blue: 223/255.0, alpha: 1.0)
        
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
    }
    
    
    func postToFirebase() {
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        counter += 1
        
        let post: Dictionary<String, Any> = [
            "goodThing": goodInput.text!,
            "year": year,
            "month": month,
            "day": day,
            "index": counter
        ]
        
        let firebasePost = DataService.ds.REF_USER_CURRENT.child("posts").childByAutoId()
        firebasePost.setValue(post)
        DataService.ds.REF_USER_CURRENT.child("totalCount").setValue(counter)
        updateCounter()
    }
    
    
    func updateCounter() {
        
        let ref = DataService.ds.REF_USER_CURRENT.child("totalCount")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let count = snapshot.value as? Int {
                self.counter = count
                self.goodCounter.text = String(describing: self.counter)
            }
        })
    }
    

    @IBAction func postGoodThing(_ sender: Any) {
        if goodInput.text != nil && goodInput.text != "" {
            postToFirebase()
            goodInput.text = ""
        }
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSplash", sender: nil)
    }
}
