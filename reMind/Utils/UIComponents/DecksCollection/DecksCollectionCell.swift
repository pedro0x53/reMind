//
//  DecksCollectionCell.swift
//  reMind
//
//  Created by Pedro Sousa on 03/02/21.
//

import UIKit

class DecksCollectionCell: UICollectionViewCell {

    public static let identifier: String = "DecksCollectionCellIdentifier"

    private let frontCard: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray
        return view
    }()

    private let backCard: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray2
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Deck Name"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.addSubview(backCard)
        backCard.translatesAutoresizingMaskIntoConstraints = true
        backCard.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        backCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        backCard.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backCard.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(frontCard)
        frontCard.translatesAutoresizingMaskIntoConstraints = true
        frontCard.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        frontCard.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        frontCard.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        frontCard.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true

        frontCard.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: frontCard.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: frontCard.centerYAnchor).isActive = true
    }

    public func configure() {}
    
}
