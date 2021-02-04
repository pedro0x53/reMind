//
//  ReviewCard.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

class ReviewCard: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "0 items to review"
        label.tintColor = .eerieBlack
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        return label
    }()

    private let reviewButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitleColor(.eerieBlack, for: .normal)
        button.backgroundColor = .mauve
        button.setTitle("Review Now", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
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
        self.layer.cornerRadius = 10

        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true

        self.addSubview(reviewButton)
        reviewButton.translatesAutoresizingMaskIntoConstraints = false
        reviewButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24).isActive = true
        reviewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        reviewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        reviewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    public func configure() {}

    public func setReviewButtonAction(target: Any?, action: Selector) {
        self.reviewButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
