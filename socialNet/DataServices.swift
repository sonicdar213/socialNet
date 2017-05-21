//
//  DataServices.swift
//  socialNet
//
//  Created by Truong Son Nguyen on 5/20/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import Foundation
import Firebase

let DB_base = FIRDatabase.database().reference()
class DataServices {
    
    static let ds = DataServices()
    
    private var _REF_BASE = DB_base
    private var _REF_POSTS = DB_base.child("post")
    private var _REF_USERS = DB_base.child("users")
    
    var REF_BASE:FIRDatabaseReference{
        return _REF_BASE
    }
    var REF_POST:FIRDatabaseReference{
        return _REF_POSTS
    }
    var REF_USERS:FIRDatabaseReference{
        return _REF_USERS
    }
    
    
    func createFirebaseDBUser(uid:String , userDATA:Dictionary<String,String>){
        REF_USERS.child(uid).updateChildValues(userDATA)
    }
}
