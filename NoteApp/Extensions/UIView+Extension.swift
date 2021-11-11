//
//  UIView+Extension.swift
//  NoteApp
//
//  Created by Avudari Sudheer Babu on 28/09/21.
//

import UIKit

extension UIView {
   @IBInspectable var cornerRadius: CGFloat{
        get { return cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
