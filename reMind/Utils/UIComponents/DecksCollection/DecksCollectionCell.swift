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
        view.backgroundColor = .systemGray5
        return view
    }()

    private let backCard: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray4
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Deck Name"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
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
        self.addSubview(backCard)
        backCard.translatesAutoresizingMaskIntoConstraints = false
        backCard.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        backCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        backCard.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backCard.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(frontCard)
        frontCard.translatesAutoresizingMaskIntoConstraints = false
        frontCard.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        frontCard.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        frontCard.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        frontCard.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true

        frontCard.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: frontCard.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: frontCard.trailingAnchor, constant: -20).isActive = true
        label.centerYAnchor.constraint(equalTo: frontCard.centerYAnchor).isActive = true
    }

    public func configure(name: String, theme: Int) {
        switch theme {
        case 1:
            self.frontCard.backgroundColor = .mauve
            self.backCard.backgroundColor = .mauveShadow
        case 2:
            self.frontCard.backgroundColor = .lavanderBlue
            self.backCard.backgroundColor = .lavanderBlueShadow
        case 3:
            self.frontCard.backgroundColor = .magicMint
            self.backCard.backgroundColor = .magicMintShadow
        default:
            self.frontCard.backgroundColor = .mauve
            self.backCard.backgroundColor = .mauveShadow
        }

        self.label.text = name
    }
    
}
