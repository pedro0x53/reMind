//
//  UITextField.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

extension UITextField {

    public func padding(right: CGFloat, left: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        self.leftViewMode = .always

        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
        self.rightViewMode = .always
    }
}
