//
//  DeckInfo.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

class DeckInfo: UIView {

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "elipses_background"))
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        return imageView
    }()

    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()

    public let reviewCard: ReviewCard = ReviewCard()

    public let tableView: WordsTable = WordsTable()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .white

        self.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        self.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blurView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        self.addSubview(reviewCard)
        reviewCard.translatesAutoresizingMaskIntoConstraints = false
        reviewCard.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        reviewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        reviewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        reviewCard.heightAnchor.constraint(equalToConstant: 163).isActive = true

        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: reviewCard.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

}
