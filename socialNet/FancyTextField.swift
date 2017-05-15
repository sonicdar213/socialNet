//
//  FancyTextField.swift
//  socialNet
//
//  Created by Truong Son Nguyen on 5/15/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit

class FancyTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.2).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
        
    
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 12, dy: 11)
        
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 12, dy: 11)
    }

}
