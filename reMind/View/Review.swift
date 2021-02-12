//
//  Home.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit

class Review: UIView {

    let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "elipses_background"))
        imageView.clipsToBounds = true
        imageView.contentMode = .center
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

    public let card: SwipeCard = {
        let width = UIScreen.main.bounds.width * 0.9
        let card = SwipeCard(frame: CGRect(x: 0, y: 0, width: width, height: width + 50))
        return card
    }()

    public let stopButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .eerieBlack
        button.setTitle("Stop Reviewing", for: .normal)
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

        self.addSubview(rememberLabel)
        rememberLabel.translatesAutoresizingMaskIntoConstraints = false
        rememberLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        rememberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(card)
        card.center.x = self.center.x
        card.center.y = self.center.y

        self.addSubview(stopButton)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35).isActive = true
        stopButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35).isActive = true
        stopButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60).isActive = true
        stopButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
