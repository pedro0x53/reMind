//
//  EditiTermViewController.swift
//  FlashCards
//
//  Created by Pedro Sousa on 22/10/20.
//

import UIKit
import CoreData

class EditiTermViewController: UIViewController {

    private let newTerm = NewTerm()

    public var card: NSManagedObject?

    private let coreDataManager = CoreDataManager.shared

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
        setupTextFields()
        setupGestures()
    }

    private func setupNavBar() {
        self.title = "Edit Term"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
    }

    @objc private func doneAction() {
        if let termStr = newTerm.termTextField.text, !termStr.isEmpty,
           let meaningStr = newTerm.meaningTextField.text, !meaningStr.isEmpty {
            if let card = self.card {
                card.setValue(termStr, forKey: "term")
                card.setValue(meaningStr, forKey: "meaning")
            }
        } else {
            let alert = UIAlertController(title: "Required Fields", message: "Fill in all fields to save the alterations", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }

        coreDataManager.updateContext()

        self.navigationController?.popViewController(animated: true)
    }

    private func setupGestures() {
        let endEditingGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(endEditingGesture)
    }

    @objc private func endEditing() {
        view.endEditing(true)
    }

    private func setupTextFields() {
        if let card = self.card {
            if let term = card.value(forKey: "term") as? String, let meaning = card.value(forKey: "meaning") as? String {
                self.newTerm.termTextField.text = term
                self.newTerm.meaningTextField.text = meaning
            }
        }
    }
}
