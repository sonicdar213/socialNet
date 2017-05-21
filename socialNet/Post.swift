//
//  Post.swift
//  socialNet
//
//  Created by Truong Son Nguyen on 5/21/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import Foundation

class Post {
    private var _caption: String!
    private var _image: String!
    private var _like: Int!
    private var _posyKEY:String!
    
    var caption:String {
        return _caption
    }
    var image:String {
        return _image
    }
    var like:Int {
        return _like
    }
    var postKEY:String{
        return _posyKEY
    }
    init(caption:String, image:String , like:Int) {
        self._caption = caption
        self._image = image
        self._like = like
    }
    init(postKEY:String, postDATA: Dictionary<String,AnyObject>){
        self._posyKEY = postKEY
        
        if let caption = postDATA["caption"] as? String {
            self._caption = caption
        }
        if let image = postDATA["image"] as? String {
            self._image = image
        }
        if let like = postDATA["like"] as? Int {
            self._like = like
        }
    }
}
