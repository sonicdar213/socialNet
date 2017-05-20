//
//  ViewController.swift
//  socialNet
//
//  Created by Truong Son Nguyen on 5/14/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper

class SinginVC: UIViewController {

    @IBOutlet weak var emailFi: FancyTextField!
    
    @IBOutlet weak var passwordFi: FancyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

            }
    override func viewDidAppear(_ animated: Bool) {
        // checking if the user has already logged in before
        if let _ = KeychainWrapper.standard.string(forKey: Key_UID ) {
            print("JESS:ID found keychain")
            performSegue(withIdentifier: "GoToFeed", sender: nil)
          

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func faceBtnpressed(_ sender: Any) {
        
        let faceLogin = FBSDKLoginManager()
        faceLogin.logIn(withReadPermissions: ["email"], from: self) {(result, error) in
            if error != nil {
                print("JESS:Unable to authenticate with Facebook - \(String(describing: error))")
            }else if result?.isCancelled == true {
                print("JESS:FB authentication is missout")
            }else{
                print("Succesfully")
                let crenden = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(crenden)
            }
         
        }
    }
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: {(user,error) in
            if error != nil {
                print("JESS:Unable to authenticate with Firebase -\(String(describing: error))")
            } else {
                print("JESS:Succesfullt authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignin(id:user.uid, userData: userData)
                }
                
            }
        })
    
}
    @IBAction func SignINPress(_ sender: Any) {
        if let email = emailFi.text , let pass = passwordFi.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: {(user, error) in
                if error == nil {
                    print("JESS:Email Autheticated with Firebase ")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignin(id:user.uid, userData: userData)
                    }
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user,error) in
                        if error != nil {
                            print("Unalble to authenticate with Firebase using email")
                        } else {
                            print("Succesfully authenticate Firebase using email")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignin(id:user.uid, userData: userData)
                            }
                    }
                  })
                }
            })
        }
    }
    func completeSignin(id:String,userData:Dictionary<String,String>){
        DataServices.ds.createFirebaseDBUser(uid: id, userDATA: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey:Key_UID)
        print("JESS: DATA to keuchain \(keychainResult)")
        performSegue(withIdentifier: "GoToFeed", sender: nil)
    }

}
