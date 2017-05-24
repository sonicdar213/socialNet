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
import FirebaseDatabase
class Feed: UIViewController , UITableViewDelegate , UITableViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var addImage: CircleView!
    @IBOutlet weak var captionField: FancyTextField!
    
    var posts = [Post]()
    var imagePicker:UIImagePickerController!
    var imgSelected = false
    static var imagecache:NSCache<NSString,UIImage> = NSCache()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        
        DataServices.ds.REF_POST.observe(.value , with : {(snapshot) in
            print(snapshot.value as Any)
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key
                        let post = Post(postKEY: key, postDATA: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
    })
    // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let post = posts[indexPath.row]
//        print("\(post.caption)")
//      
        let post = posts[indexPath.row]
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
//            var img :UIImage!
            
            if let img =  Feed.imagecache.object(forKey: post.image as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
           
        } else {
            return PostCell()
        }
        //        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.image = image
            imgSelected = true
        }else{
            print(" A valid image wasnt selected")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addimageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        guard let caption = captionField.text, caption != "" else {
            print("JESS:Caption must be entered")
            return
        }
        guard let img = addImage.image,imgSelected == true else {
            print("JESSL: An Image must be selected")
            return
        }
        if let imgData = UIImageJPEGRepresentation(img, 0.2){
            let imgUid = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            DataServices.ds.REF_POST_IMAGEs.child(imgUid).put(imgData,metadata:metaData) {(metadata,error) in
                if error != nil {
                    print("JESS:Unable to upload image from Firebase Storage")
                } else {
                    print("JESS:Successfully uploaded")
                    let downloadURL = metaData.downloadURL()?.absoluteString
            }
        }
    }
}
    @IBAction func SignOutTapped(_ sender: Any) {
       let keychainResult =  KeychainWrapper.standard.removeObject(forKey: Key_UID)
        print("JESS: \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "GotoSignIN", sender: nil)
    }

}
