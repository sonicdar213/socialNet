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
let STORAGE_BASE = FIRStorage.storage().reference()
class DataServices {
    
    static let ds = DataServices()
    
    // DB references
    private var _REF_BASE = DB_base
    private var _REF_POSTS = DB_base.child("post")
    private var _REF_USERS = DB_base.child("users")
    
    //Storage references
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-image")
    var REF_BASE:FIRDatabaseReference{
        return _REF_BASE
    }
    var REF_POST:FIRDatabaseReference{
        return _REF_POSTS
    }
    var REF_USERS:FIRDatabaseReference{
        return _REF_USERS
    }
    var REF_POST_IMAGEs : FIRStorageReference{
        return _REF_POST_IMAGES
    }
    
    func createFirebaseDBUser(uid:String , userDATA:Dictionary<String,String>){
        REF_USERS.child(uid).updateChildValues(userDATA)
    }
}
