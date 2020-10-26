//
//  NewTerm.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit

class NewTerm: UIView {

    private let termLabel: UILabel = {
        let label = UILabel()
        label.text = "Term"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.lineBreakMode = .byCharWrapping
        label.tintColor = .eerieBlack
        return label
    }()

    public let termTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 44))
        textField.placeholder = "Outrageously"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .none
        let bottomLine = CALayer()
        let frame = textField.frame
        bottomLine.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.eerieBlack.withAlphaComponent(0.3).cgColor
        textField.layer.addSublayer(bottomLine)
        return textField
    }()

    private let meaningLabel: UILabel = {
        let label = UILabel()
        label.text = "Meaning"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.lineBreakMode = .byCharWrapping
        label.tintColor = .eerieBlack
        return label
    }()

    public let meaningTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 44))
        textField.placeholder = "in a shockingly bad or excessive way."
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .none
        let bottomLine = CALayer()
        let frame = textField.frame
        bottomLine.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.eerieBlack.withAlphaComponent(0.3).cgColor
        textField.layer.addSublayer(bottomLine)
        return textField
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

        self.addSubview(termLabel)
        termLabel.translatesAutoresizingMaskIntoConstraints = false
        termLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        termLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        self.addSubview(termTextField)
        termTextField.translatesAutoresizingMaskIntoConstraints = false
        termTextField.topAnchor.constraint(equalTo: termLabel.bottomAnchor).isActive = true
        termTextField.leadingAnchor.constraint(equalTo: termLabel.leadingAnchor).isActive = true
        termTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        termTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true

        self.addSubview(meaningLabel)
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        meaningLabel.topAnchor.constraint(equalTo: termTextField.bottomAnchor, constant: 20).isActive = true
        meaningLabel.leadingAnchor.constraint(equalTo: termLabel.leadingAnchor).isActive = true

        self.addSubview(meaningTextField)
        meaningTextField.translatesAutoresizingMaskIntoConstraints = false
        meaningTextField.topAnchor.constraint(equalTo: meaningLabel.bottomAnchor, constant: 4).isActive = true
        meaningTextField.leadingAnchor.constraint(equalTo: meaningLabel.leadingAnchor).isActive = true
        meaningTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        meaningTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

}
