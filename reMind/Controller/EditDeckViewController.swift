//
//  EditDeckViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

class EditDeckViewController: UIViewController {

    private let editDeckview = NewDeck()

    override func loadView() {
        super.loadView()
        self.view = self.editDeckview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    private func setupNavBar() {
        self.title = "Edit Deck"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveAction))

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(cancelAction))
        
    }

    @objc private func saveAction() {
        if let name = editDeckview.nameTextField.text, !name.isEmpty {
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Required Fields", message: "To create a deck you need to fill in at least the name field.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
    }

    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

}
