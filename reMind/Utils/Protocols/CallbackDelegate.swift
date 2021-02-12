//
//  CallbackDelegate.swift
//  FlashCards
//
//  Created by Pedro Sousa on 22/10/20.
//

import Foundation

enum ResultType {
    case success, failure
}

protocol CallbackDelegate: AnyObject {
    func callback(_ result: ResultType)
}
