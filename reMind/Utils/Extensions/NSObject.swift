//
//  NSObject.swift
//  reMind
//
//  Created by Pedro Sousa on 13/07/23.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
