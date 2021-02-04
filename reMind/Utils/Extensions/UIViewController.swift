//
//  UIViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

extension UIViewController {

    var isModal: Bool {
            if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
                return false
            } else if presentingViewController != nil {
                return true
            } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
                return true
            } else if tabBarController?.presentingViewController is UITabBarController {
                return true
            } else {
                return false
            }
        }
}
