//
//  NewTermViewController.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit

class NewTermViewController: UIViewController {

    private let newTerm = NewTerm()

    private let coreDataManager = CoreDataManager.shared

    public weak var delegate: CallbackDelegate?

    override func loadView() {
        super.loadView()
        self.view = self.newTerm
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGestures()
        setupNavBar()
    }

    private func setupNavBar() {
        self.title = "New Word"

        if self.isModal {
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
            self.navigationController?.navigationBar.topItem?.leftBarButtonItem = cancelButton
        } else {
            let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveAction))
    }

    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func saveAction() {
        guard let termStr = newTerm.wordTextField.text else { return }
        guard let meaningStr = newTerm.wordTextField.text else { return }

        if termStr.isEmpty || meaningStr.isEmpty {
            let alert = UIAlertController(title: "Required Fields", message: "Fill in all fields to save the card", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        coreDataManager.createFlashCard(term: termStr, meaning: meaningStr)
        self.dismiss(animated: true, completion: { [unowned self] in
            dismissNewTerm()
        })
    }

    private func setupGestures() {
        let endEditingGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(endEditingGesture)
    }

    @objc private func endEditing() {
        view.endEditing(true)
    }

    private func dismissNewTerm() {
        if let delegate = self.delegate {
            delegate.callback()
        }
    }
}
