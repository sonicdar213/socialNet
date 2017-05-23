//
//  PostCell.swift
//  socialNet
//
//  Created by Truong Son Nguyen on 5/19/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit
import Firebase
class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernamelbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likelbl: UILabel!
    
    var post : Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Init code
    }

    func configureCell(post:Post, img:UIImage? = nil ) {
        self.post = post
        self.caption.text = post.caption
        self.likelbl.text = "\(post.like)"
        
        if img != nil {
            self.postImg.image = img
            
        } else {
        let ref = FIRStorage.storage().reference(forURL: post.image)
            ref.data(withMaxSize: 2 * 1024 * 1024 , completion: {(data,error) in
                if error != nil {
                    print("Jess:Unalbe to download img from FirebaseStorage")
                } else {
                    print("Succes img has downloaded")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            Feed.imagecache.setObject(img, forKey:post.image as NSString)
                            
                        }
                    }
                }
            

        })
    }
   
}
}
