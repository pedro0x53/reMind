//
//  ManageWordViewController.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit

class ManageWordViewController: UIViewController {

    private let manageWord = ManageWord()

    private var viewModel = ManageWordViewModel()

    public weak var delegate: CallbackDelegate?

    override func loadView() {
        super.loadView()
        self.view = self.manageWord
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFieldsDelegate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGestures()
        setupNavBar()
    }

    private func setupNavBar() {
        self.title = "New Word"

        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = cancelButton

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveAction))
    }

    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func saveAction() {
        guard let wordStr = manageWord.wordTextField.text else { return }
        guard let meaningStr = manageWord.meaningTextView.textView.text else { return }

        if wordStr.isEmpty || meaningStr.isEmpty {
            let alert = UIAlertController(title: "Required Fields", message: "Fill in all fields to save the new word", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            if self.viewModel.setCardWith(word: wordStr, meaning: meaningStr) {
                self.delegate?.callback(.success)
            } else {
                self.delegate?.callback(.failure)
            }
        }

        self.dismiss(animated: true, completion: nil)
    }

    func setCard(_ card: Card) {
        self.viewModel.card = card
        fillForm()
    }

    func setDeckID(_ deckID: String) {
        self.viewModel.deckID = deckID
    }

    private func fillForm() {
        if let card = self.viewModel.card {
            self.manageWord.wordTextField.text = card.word
            self.manageWord.meaningTextView.text = card.meaning
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

extension ManageWordViewController: UITextFieldDelegate, UITextViewDelegate {
    private func setupFieldsDelegate() {
        self.manageWord.wordTextField.delegate = self
        self.manageWord.meaningTextView.delegate = self
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
