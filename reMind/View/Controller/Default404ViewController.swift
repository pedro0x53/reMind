//
//  Default404ViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

class Default404ViewController: UIViewController {

    private let default404View = Default404()

    override func loadView() {
        self.view = self.default404View
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
