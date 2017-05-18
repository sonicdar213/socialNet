//
//  Feed.swift
//  socialNet
//
//  Created by Truong Son Nguyen on 5/17/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
class Feed: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func SignOutTapped(_ sender: Any) {
       let keychainResult =  KeychainWrapper.standard.removeObject(forKey: Key_UID)
        print("JESS: \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "GotoSignIN", sender: nil)
    }

}
