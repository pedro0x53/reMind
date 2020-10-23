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
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()

    public let rememberLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.tintColor = .eerieBlack
        return label
    }()

    public let card: Card = {
        let width = UIScreen.main.bounds.width * 0.9
        let card = Card(frame: CGRect(x: 0, y: 0, width: width, height: width + 50))
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
        backgroundImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        self.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blurView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        self.addSubview(card)
        card.center.x = self.center.x
        card.center.y = self.center.y

        self.addSubview(rememberLabel)
        rememberLabel.translatesAutoresizingMaskIntoConstraints = false
        rememberLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        rememberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
