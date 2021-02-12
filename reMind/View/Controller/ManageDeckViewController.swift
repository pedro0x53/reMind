//
//  ManageDeckViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 03/02/21.
//

import UIKit

class ManageDeckViewController: UIViewController {
    
    private let viewModel = ManageDeckViewModel()

    public weak var delegate: CallbackDelegate?

    private var currentTheme: Int = 0

    private let manageDeckView = ManageDeckView()

    override func loadView() {
        super.loadView()
        self.view = self.manageDeckView
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
        if let _ = self.viewModel.deck {
            self.title = "Edit Deck"
        } else {
            self.title = "New Deck"
            self.manageDeckView.radioButtonsGroup.select(at: 0)
            
        }

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,
                                                                target: self, action: #selector(cancelAction))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",style: .done,
                                                                 target: self, action: #selector(manageAction))
    }

    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func manageAction() {
        if let name = manageDeckView.nameTextField.text, !name.isEmpty {
            let descriptionText = manageDeckView.descriptionTextView.textView.text
            let keywordsText = manageDeckView.keywordsTextField.text
            
            if self.viewModel.setDeckWith(name: name, description: descriptionText!,
                                          keywords: keywordsText!, themeID: self.currentTheme) {
                if let delegate = self.delegate {
                    delegate.callback(.success)
                }
            } else {
                if let delegate = self.delegate {
                    delegate.callback(.failure)
                }
            }

            self.navigationController?.dismiss(animated: true, completion: nil)
        } else {
            let alert = self.generateAlert()
            self.present(alert, animated: true, completion: nil)
        }
    }

    private func setupGestures() {
        let endEditingGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(endEditingGesture)
    }

    @objc private func endEditing() {
        view.endEditing(true)
    }

    func setDeck(_ deck: Deck) {
        self.viewModel.deck = deck
        fillForm()
    }

    private func fillForm() {
        if let deck = self.viewModel.deck {
            self.manageDeckView.nameTextField.text = deck.name
            self.manageDeckView.descriptionTextView.text = deck.descriptionText
            self.manageDeckView.keywordsTextField.text = deck.keywords
            self.manageDeckView.radioButtonsGroup.select(at: Int(deck.themeID))
        }
    }

    private func generateAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Required Fields",
                                      message: "To create a deck you need to fill in at least the name field.",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)

        return alert
    }
}

extension ManageDeckViewController: UITextFieldDelegate, UITextViewDelegate, RadioButtonGroupDelegate {
    private func setupFieldsDelegate() {
        self.manageDeckView.nameTextField.delegate = self
        self.manageDeckView.descriptionTextView.delegate = self
        self.manageDeckView.keywordsTextField.delegate = self
        self.manageDeckView.radioButtonsGroup.delegate = self
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let customTextFiel = textField as? CustomTextField else { return false }
        return customTextFiel.verifyField(shouldChangeCharactersIn: range, replacementString: string)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let customTextView = textView.superview as? CustomTextView else { return false }
        return customTextView.verifyField(shouldChangeCharactersIn: range, replacementString: text)
    }

    func didSelect(at index: Int) {
        self.currentTheme = index
    }
}
