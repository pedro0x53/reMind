//
//  NewTerm.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit

class ManageWord: UIView {

    private let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "Word"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.lineBreakMode = .byCharWrapping
        label.tintColor = .eerieBlack
        return label
    }()

    public let wordTextField: CustomTextField = {
        let width = UIScreen.main.bounds.width - 40
        let customTextField = CustomTextField(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        customTextField.maxLength = 35
        return customTextField
    }()

    private let meaningLabel: UILabel = {
        let label = UILabel()
        label.text = "Meaning"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.lineBreakMode = .byCharWrapping
        label.tintColor = .eerieBlack
        return label
    }()

    public let meaningTextView: CustomTextView = {
        let width = UIScreen.main.bounds.width - 40
        let customTextView = CustomTextView(frame: CGRect(x: 0, y: 0, width: width, height: 100))
        customTextView.maxLength = 150
        return customTextView
    }()

    public let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete Word", for: .normal)
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

        self.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        self.addSubview(wordTextField)
        wordTextField.translatesAutoresizingMaskIntoConstraints = false
        wordTextField.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 5).isActive = true
        wordTextField.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor).isActive = true
        wordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        wordTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true

        self.addSubview(meaningLabel)
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        meaningLabel.topAnchor.constraint(equalTo: wordTextField.bottomAnchor, constant: 20).isActive = true
        meaningLabel.leadingAnchor.constraint(equalTo: wordTextField.leadingAnchor).isActive = true

        self.addSubview(meaningTextView)
        meaningTextView.translatesAutoresizingMaskIntoConstraints = false
        meaningTextView.topAnchor.constraint(equalTo: meaningLabel.bottomAnchor, constant: 5).isActive = true
        meaningTextView.leadingAnchor.constraint(equalTo: meaningLabel.leadingAnchor).isActive = true
        meaningTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        meaningTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        self.addSubview(deleteButton)
        deleteButton.isHidden = true
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
