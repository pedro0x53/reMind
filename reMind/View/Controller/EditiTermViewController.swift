//
//  EditiTermViewController.swift
//  FlashCards
//
//  Created by Pedro Sousa on 22/10/20.
//

import UIKit

class EditiTermViewController: UIViewController {

    private let newTerm = NewTerm()

//    public var card: NSManagedObject?

//    private let coreDataManager = CoreDataManager.shared

    override func loadView() {
        super.loadView()
        self.view = self.newTerm
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFieldsDelegate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTextFields()
        setupGestures()
        setupNavBar()
    }

    private func setupNavBar() {
        self.title = "Edit Word"

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancelAction))

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(doneAction))
    }

    @objc private func doneAction() {
        if let termStr = newTerm.wordTextField.text, !termStr.isEmpty,
           let meaningStr = newTerm.meaningTextView.textView.text, !meaningStr.isEmpty {
//            if let card = self.card {
//                card.setValue(termStr, forKey: "term")
//                card.setValue(meaningStr, forKey: "meaning")
//            }
        } else {
            let alert = UIAlertController(title: "Required Fields", message: "Fill in all fields to save the alterations", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }

//        coreDataManager.updateContext()

        self.navigationController?.popViewController(animated: true)
    }

    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    private func setupGestures() {
        let endEditingGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(endEditingGesture)
    }

    @objc private func endEditing() {
        view.endEditing(true)
    }

    private func setupTextFields() {
//        if let card = self.card {
//            if let term = card.value(forKey: "term") as? String, let meaning = card.value(forKey: "meaning") as? String {
//                self.newTerm.wordTextField.text = term
//                self.newTerm.meaningTextView.textView.text = meaning
//            }
//        }
    }
}

extension EditiTermViewController: UITextFieldDelegate, UITextViewDelegate {
    private func setupFieldsDelegate() {
        self.newTerm.wordTextField.delegate = self
        self.newTerm.meaningTextView.delegate = self
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
