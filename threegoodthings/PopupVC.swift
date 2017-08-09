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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goodPopup.layer.cornerRadius = 25
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
