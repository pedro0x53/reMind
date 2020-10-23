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
        setupNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGestures()
    }

    private func setupNavBar() {
        self.title = "New Term"
        
        navigationController?.navigationBar.tintColor = .eerieBlack
        navigationController?.navigationBar.shadowImage = UIImage()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveAction))
    }

    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func saveAction() {
        guard let termStr = newTerm.termTextField.text else { return }
        guard let meaningStr = newTerm.meaningTextField.text else { return }

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
