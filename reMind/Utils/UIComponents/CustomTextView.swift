//
//  CustomTextView.swift
//  reMind
//
//  Created by Pedro Sousa on 05/02/21.
//

import UIKit

class CustomTextView: UIView {

    var text: String? = "" {
        didSet {
            self.textView.text = text
            self.maxLengthLabel.text = "\(self.maxLength - self.textView.text.count)"
        }
    }

    weak var delegate: UITextViewDelegate? {
        didSet {
            self.textView.delegate = self.delegate
        }
    }

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

    public let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false

        let separator = CALayer()
        separator.backgroundColor = UIColor.systemGray4.cgColor
        separator.frame = CGRect(x: 0, y: textView.frame.height - 1,
                                 width: textView.frame.size.width, height: 1)
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
        self.backgroundColor = .clear

        self.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        self.addSubview(maxLengthLabel)
        maxLengthLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLengthLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        maxLengthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }

    public func verifyField(shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = self.textView.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        if updatedText.count <= self.maxLength {
            self.maxLengthLabel.text = "\(self.maxLength - updatedText.count)"
            return true
        }

        return false
    }
}
