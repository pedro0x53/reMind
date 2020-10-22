//
//  Home.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit

class Home: UIView {

    let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "elipses_background"))
        imageView.clipsToBounds = false
        imageView.contentMode = .top
        return imageView
    }()

    public let rememberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.tintColor = .eerieBlack
        return label
    }()

    public let card: Card = {
        let card = Card(frame: CGRect(x: 0, y: 0, width: 330, height: 380))
        return card
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

        self.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        let blurEffect = UIBlurEffect(style: .systemThinMaterialLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backgroundImage.frame
        self.addSubview(blurredEffectView)

        self.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30).isActive = true
        card.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        card.widthAnchor.constraint(equalToConstant: 330).isActive = true
        card.heightAnchor.constraint(equalToConstant: 380).isActive = true

        self.addSubview(rememberLabel)
        rememberLabel.translatesAutoresizingMaskIntoConstraints = false
        rememberLabel.bottomAnchor.constraint(equalTo: card.topAnchor, constant: -25).isActive = true
        rememberLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor).isActive = true
    }
}
