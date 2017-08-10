//
//  PopupVC.swift
//  threegoodthings
//
//  Created by Steven Buchko on 8/8/17.
//  Copyright © 2017 Steven Buchko. All rights reserved.
//

import UIKit

class PopupVC: UIViewController {
    
    @IBOutlet weak var goodPopup: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goodPopup.layer.cornerRadius = 25
        
        getRandomGoodThing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getRandomGoodThing() {
        var postIndex = Int()
        
        DataService.ds.REF_USER_CURRENT.child("totalCount").observeSingleEvent(of: .value, with: { (snapshot) in
            if let count = snapshot.value as? Int {
                postIndex = Int(arc4random_uniform(UInt32(count)) + 1)
            }
        })
        
        let ref = DataService.ds.REF_USER_CURRENT.child("posts")
        
        
        ref.queryOrdered(byChild: "index").queryEqual(toValue: postIndex).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let year = snapshot.child["year"] as? String {
                self.yearLabel.text = year
            }
            
        })
    }

}
