//
//  NewDeck.swift
//  reMind
//
//  Created by Pedro Sousa on 03/02/21.
//

import UIKit

class NewDeck: UIView {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .cultured
        textField.borderStyle = .none

        var separator = CALayer()
        separator.backgroundColor = UIColor.gray.cgColor
        separator.frame = CGRect(x: textField.frame.minX, y: textField.frame.maxY,
                                  width: textField.frame.width, height: 1)
        textField.layer.addSublayer(separator)
        return textField
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.backgroundColor = .cultured

        var separator = CALayer()
        separator.backgroundColor = UIColor.gray.cgColor
        separator.frame = CGRect(x: textView.frame.minX, y: textView.frame.maxY,
                                  width: textView.frame.width, height: 1)
        textView.layer.addSublayer(separator)
        return textView
    }()

    private let keywordsLabel: UILabel = {
        let label = UILabel()
        label.text = "Keywords"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    private let keywordsTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .cultured
        textField.borderStyle = .none

        var separator = CALayer()
        separator.backgroundColor = UIColor.gray.cgColor
        separator.frame = CGRect(x: textField.frame.minX, y: textField.frame.maxY,
                                  width: textField.frame.width, height: 1)
        textField.layer.addSublayer(separator)
        return textField
    }()

    private let keywordsFootnote: UILabel = {
        let label = UILabel()
        label.text = "Separated by “,” (comma). E.g. english, grammar"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        self.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true

        self.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        self.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true

        self.addSubview(keywordsLabel)
        keywordsLabel.translatesAutoresizingMaskIntoConstraints = false
        keywordsLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16).isActive = true
        keywordsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        self.addSubview(keywordsTextField)
        keywordsTextField.translatesAutoresizingMaskIntoConstraints = false
        keywordsTextField.topAnchor.constraint(equalTo: keywordsLabel.bottomAnchor, constant: 5).isActive = true
        keywordsTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        keywordsTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true

        self.addSubview(keywordsFootnote)
        keywordsFootnote.translatesAutoresizingMaskIntoConstraints = false
        keywordsFootnote.topAnchor.constraint(equalTo: keywordsTextField.bottomAnchor, constant: 3).isActive = true
        keywordsFootnote.leadingAnchor.constraint(equalTo: keywordsTextField.leadingAnchor).isActive = true
        keywordsFootnote.trailingAnchor.constraint(equalTo: keywordsTextField.trailingAnchor).isActive = true
    }
}
