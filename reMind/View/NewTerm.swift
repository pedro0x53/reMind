//
//  NewTerm.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit

class NewTerm: UIView {

    private let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "Word"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.lineBreakMode = .byCharWrapping
        label.tintColor = .eerieBlack
        return label
    }()

    public let wordTextField: UITextField = {
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

    private let meaningLabel: UILabel = {
        let label = UILabel()
        label.text = "Meaning"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.lineBreakMode = .byCharWrapping
        label.tintColor = .eerieBlack
        return label
    }()

    public let meaningTextView: UITextView = {
        let width = UIScreen.main.bounds.width - 40
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: 100))
        textView.isEditable = true
        textView.backgroundColor = .cultured

        textView.font = .systemFont(ofSize: 20, weight: .regular)

        var separator = CALayer()
        separator.backgroundColor = UIColor.systemGray4.cgColor
        separator.frame = CGRect(x: 0, y: textView.frame.height - 1,
                                 width: width, height: 1)
        textView.layer.addSublayer(separator)
        textView.layer.masksToBounds = true
        return textView
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
    }

}
