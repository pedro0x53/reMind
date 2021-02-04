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
        super.loadView()
        self.view = self.newDeckView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
    }

    private func setupNavBar() {
        self.title = "New Deck"

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(cancelAction))

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(nextAction))
    }

    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func nextAction() {
        if let name = newDeckView.nameTextField.text, !name.isEmpty {
            let controller = NewDeckAddWordsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            let alert = UIAlertController(title: "Required Fields", message: "To create a deck you need to fill in at least the name field.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
    }

    private func setupGestures() {
        let endEditingGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(endEditingGesture)
    }

    @objc private func endEditing() {
        view.endEditing(true)
    }
}
