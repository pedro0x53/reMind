//
//  NewHome.swift
//  reMind
//
//  Created by Pedro Sousa on 03/02/21.
//

import UIKit

class NewHome: UIView {

//    private let segmentedCrontrol: UISegmentedControl = {
//        let segmentedControl = UISegmentedControl(items: ["All", "My Decks", "Shared"])
//        segmentedControl.selectedSegmentIndex = 0
//        return segmentedControl
//    }()

    public let decksCollection = DecksCollection()

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "elipses_background"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
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

//        self.addSubview(segmentedCrontrol)
//        segmentedCrontrol.translatesAutoresizingMaskIntoConstraints = false
//        segmentedCrontrol.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        segmentedCrontrol.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(decksCollection)
        decksCollection.translatesAutoresizingMaskIntoConstraints = false
        decksCollection.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        decksCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        decksCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        decksCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
