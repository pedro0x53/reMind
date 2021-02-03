//
//  NewDeckViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 03/02/21.
//

import UIKit

class NewDeckViewController: UIViewController {

    private let newDeckView = NewDeck()

    override func loadView() {
        self.view = self.newDeckView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setupNavBar() {
        self.title = "New Deck"

//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: ., target: <#T##Any?#>, action: <#T##Selector?#>)
    }
}
