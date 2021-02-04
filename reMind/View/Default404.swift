//
//  Default404.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

class Default404: UIView {

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

    private let bigfootImage: UIImageView = {
        let image = UIImage(named: "bigfoot")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let message: UILabel = {
        let label = UILabel()
        label.text = "We are still working on this functionality"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.tintColor = .eerieBlack
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

        self.addSubview(bigfootImage)
        bigfootImage.translatesAutoresizingMaskIntoConstraints = false
        bigfootImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bigfootImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30).isActive = true
//        bigfootImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
//        bigfootImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        let width = UIScreen.main.bounds.width - 100
        bigfootImage.heightAnchor.constraint(equalToConstant: width * 1.17).isActive = true
        bigfootImage.widthAnchor.constraint(equalToConstant: width).isActive = true

        self.addSubview(message)
        message.translatesAutoresizingMaskIntoConstraints = false
        message.topAnchor.constraint(equalTo: bigfootImage.bottomAnchor, constant: 20).isActive = true
        message.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        
    }

}
