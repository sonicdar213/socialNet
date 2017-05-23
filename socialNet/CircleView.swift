//
//  CircleView.swift
//  socialNet
//
//  Created by Truong Son Nguyen on 5/19/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.8
       
    }
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        
//    }
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width/2
        clipsToBounds = true
    }
}
