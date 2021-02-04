//
//  WordsTableHeader.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

class WordsTableHeader: UITableViewHeaderFooterView {

    public static let identifier: String = "WordsTableHeaderIdentifier"

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Words"
        label.tintColor = .eerieBlack
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        return label
    }()

    public let addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 92, height: 35))
        button.layer.cornerRadius = 8
        button.setTitleColor(.eerieBlack, for: .normal)
        button.backgroundColor = .lavanderBlue
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()

    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        let newBackgroundView = UIView()
        newBackgroundView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.backgroundView = blurView

        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        self.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 92).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }

    public func setAddButtonAction(target: Any?, action: Selector) {
        self.addButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
