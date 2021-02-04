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

    public let nameTextField: UITextField = {
        let width = UIScreen.main.bounds.width - 40
        let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        textField.backgroundColor = .cultured
        textField.borderStyle = .none

        textField.padding(right: 10, left: 10)

        var separator = CALayer()
        separator.backgroundColor = UIColor.systemGray4.cgColor
        separator.frame = CGRect(x: 0, y: textField.frame.height - 1,
                                 width: width, height: 1)
        textField.layer.addSublayer(separator)
        textField.layer.masksToBounds = true
        return textField
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    public let descriptionTextView: UITextView = {
        let width = UIScreen.main.bounds.width - 40
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: 100))
        textView.isEditable = true
        textView.backgroundColor = .cultured

        textView.font = .systemFont(ofSize: 17, weight: .regular)

        var separator = CALayer()
        separator.backgroundColor = UIColor.systemGray4.cgColor
        separator.frame = CGRect(x: 0, y: textView.frame.height - 1,
                                 width: width, height: 1)
        textView.layer.addSublayer(separator)
        textView.layer.masksToBounds = true
        return textView
    }()

    private let keywordsLabel: UILabel = {
        let label = UILabel()
        label.text = "Keywords"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    public let keywordsTextField: UITextField = {
        let width = UIScreen.main.bounds.width - 40
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        textField.backgroundColor = .cultured
        textField.borderStyle = .none

        textField.padding(right: 10, left: 10)

        var separator = CALayer()
        separator.backgroundColor = UIColor.systemGray4.cgColor
        separator.frame = CGRect(x: 0, y: textField.frame.height - 1,
                                 width: width, height: 1)
        textField.layer.addSublayer(separator)
        textField.layer.masksToBounds = true
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
        self.backgroundColor = .white

        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        self.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true

        self.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        self.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true

        self.addSubview(keywordsLabel)
        keywordsLabel.translatesAutoresizingMaskIntoConstraints = false
        keywordsLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16).isActive = true
        keywordsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        self.addSubview(keywordsTextField)
        keywordsTextField.translatesAutoresizingMaskIntoConstraints = false
        keywordsTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        keywordsTextField.topAnchor.constraint(equalTo: keywordsLabel.bottomAnchor, constant: 5).isActive = true
        keywordsTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        keywordsTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true

        self.addSubview(keywordsFootnote)
        keywordsFootnote.translatesAutoresizingMaskIntoConstraints = false
        keywordsFootnote.topAnchor.constraint(equalTo: keywordsTextField.bottomAnchor, constant: 3).isActive = true
        keywordsFootnote.leadingAnchor.constraint(equalTo: keywordsTextField.leadingAnchor).isActive = true
        keywordsFootnote.trailingAnchor.constraint(equalTo: keywordsTextField.trailingAnchor).isActive = true
    }
}
