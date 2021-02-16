//
//  NewDeck.swift
//  reMind
//
//  Created by Pedro Sousa on 03/02/21.
//

import UIKit

class ManageDeckView: UIView {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    public let nameTextField: CustomTextField = {
        let width = UIScreen.main.bounds.width - 40
        let customTextField = CustomTextField(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        customTextField.maxLength = 35
        return customTextField
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    public let descriptionTextView: CustomTextView = {
        let width = UIScreen.main.bounds.width - 40
        let customTextView = CustomTextView(frame: CGRect(x: 0, y: 0, width: width, height: 100))
        customTextView.maxLength = 150
        return customTextView
    }()

    private let keywordsLabel: UILabel = {
        let label = UILabel()
        label.text = "Keywords"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    public let keywordsTextField: CustomTextField = {
        let width = UIScreen.main.bounds.width - 40
        let customTextField = CustomTextField(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        customTextField.maxLength = 150
        return customTextField
    }()

    private let keywordsFootnote: UILabel = {
        let label = UILabel()
        label.text = "Separated by “,” (comma). E.g. english, grammar"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()

    private let themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Theme"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    let radioButtonsGroup: RadioButtonGroup = {
        let stack = RadioButtonGroup()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }()

    public let mauveThemeButton: RadioButton = {
        let button = RadioButton(width: 35)
        button.backgroundColor = .mauve
        return button
    }()

    public let mintThemeButton: RadioButton = {
        let button = RadioButton(width: 35)
        button.backgroundColor = .magicMint
        return button
    }()

    public let lavaderThemeButton: RadioButton = {
        let button = RadioButton(width: 35)
        button.backgroundColor = .lavanderBlue
        return button
    }()

    public let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete Deck", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = UIColor.cultured
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        return button
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

        self.addSubview(themeLabel)
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        themeLabel.topAnchor.constraint(equalTo: keywordsFootnote.bottomAnchor, constant: 20).isActive = true
        themeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        self.addSubview(radioButtonsGroup)
        radioButtonsGroup.translatesAutoresizingMaskIntoConstraints = false
        radioButtonsGroup.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 15).isActive = true
        radioButtonsGroup.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        radioButtonsGroup.addRadioButton(mauveThemeButton)
        radioButtonsGroup.addRadioButton(lavaderThemeButton)
        radioButtonsGroup.addRadioButton(mintThemeButton)

        self.addSubview(deleteButton)
        deleteButton.isHidden = true
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
