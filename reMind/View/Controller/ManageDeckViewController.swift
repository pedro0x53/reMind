//
//  ManageDeckViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 03/02/21.
//

import UIKit

class ManageDeckViewController: UIViewController {
    
    private let viewModel = ManageDeckViewModel()

    public weak var homeDelegate: HomeDelegate?
    public weak var deckInfoDelegate: DeckInfoDelegate?

    private var currentTheme: Int = 0

    private let manageDeckView = ManageDeckView()

    override func loadView() {
        super.loadView()
        self.view = self.manageDeckView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        editMode()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        setupFieldsDelegate()
    }

    private func setupNavBar() {
        self.title = "New Deck"
        self.manageDeckView.radioButtonsGroup.selectedIndex = 0

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
            
            if let deck = self.viewModel.setDeckWith(name: name, description: descriptionText!,
                                          keywords: keywordsText!, themeID: self.currentTheme) {

                if let delegate = self.homeDelegate {
                    delegate.updateCollection(with: deck)
                }

                if let delegate = self.deckInfoDelegate {
                    delegate.updateInfo(with: deck)
                }
            }

            self.navigationController?.dismiss(animated: true, completion: nil)
        } else {
            let alert = self.generateAlert()
            self.present(alert, animated: true, completion: nil)
        }
    }

    private func editMode() {
        if let deck = viewModel.deck {
            self.title = "Edit Deck"
            self.manageDeckView.radioButtonsGroup.selectedIndex = Int(deck.themeID)
            self.manageDeckView.deleteButton.isHidden = false
            self.manageDeckView.deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        }
    }

    @objc func deleteAction() {
        guard let deck = self.viewModel.deck else { return }
        let title = "Delete \"\(deck.name!)\"?"
        let alert = UIAlertController(title: title,
                                      message: "Deleting this decke will remove it and it's words permanently.",
                                      preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            self.viewModel.deleteDeck()
            if let delegate = self.deckInfoDelegate {
                delegate.deleted()
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
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
            self.manageDeckView.radioButtonsGroup.selectedIndex = Int(deck.themeID)
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
