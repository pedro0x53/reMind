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
        setupFieldsDelegate()
    }

    private func setupNavBar() {
        self.title = "New Deck"

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(cancelAction))

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(saveAction))
    }

    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func saveAction() {
        if let name = newDeckView.nameTextField.text, !name.isEmpty {
            self.navigationController?.dismiss(animated: true, completion: nil)
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

extension NewDeckViewController: UITextFieldDelegate, UITextViewDelegate {
    private func setupFieldsDelegate() {
        self.newDeckView.nameTextField.delegate = self
        self.newDeckView.descriptionTextView.delegate = self
        self.newDeckView.keywordsTextField.delegate = self
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let customTextFiel = textField as? CustomTextField else { return false }
        return customTextFiel.verifyField(shouldChangeCharactersIn: range, replacementString: string)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let customTextView = textView.superview as? CustomTextView else { return false }
        return customTextView.verifyField(shouldChangeCharactersIn: range, replacementString: text)
    }
}
