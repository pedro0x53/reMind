//
//  CustomTextField.swift
//  reMind
//
//  Created by Pedro Sousa on 05/02/21.
//

import UIKit

class CustomTextField: UITextField {

    public var maxLength = 0 {
        didSet {
            self.maxLengthLabel.text = "\(self.maxLength)"
        }
    }
    private let maxLengthLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.tintColor = .systemGray6
        label.font = .systemFont(ofSize: 13, weight: .bold)
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
        self.clearButtonMode = .never

        self.backgroundColor = .systemGray6
        self.borderStyle = .none

        self.setStartSpace(10)

        let separator = CALayer()
        separator.backgroundColor = UIColor.systemGray4.cgColor
        separator.frame = CGRect(x: 0, y: self.frame.height - 1,
                                 width: self.frame.size.width, height: 1)
        self.layer.addSublayer(separator)
        self.layer.masksToBounds = true

        self.addSubview(maxLengthLabel)
        maxLengthLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLengthLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        maxLengthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }

    public func setStartSpace(_ space: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: self.frame.height))
        self.leftViewMode = .always
    }

    public func verifyField(shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = self.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        if updatedText.count <= self.maxLength {
            self.maxLengthLabel.text = "\(self.maxLength - updatedText.count)"
            return true
        }

        return false
    }
}
