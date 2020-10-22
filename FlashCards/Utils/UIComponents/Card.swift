//
//  Card.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit

class Card: UIView {

    public var showMeaning = false
    
    private let front: UIView = {
        let view = UIView()
        view.backgroundColor = .mauve
        view.layer.cornerRadius = 10
        return view
    }()

    private let back: UIView = {
        let view = UIView()
        view.backgroundColor = .lavanderBleu
        view.layer.cornerRadius = 10
        return view
    }()

    private let termLabel: UILabel = {
        let label = UILabel()
        label.text = "The term goes here"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.tintColor = .eerieBlack
        label.numberOfLines = 0
        return label
    }()
    
    private let meaningLabel: UILabel = {
        let label = UILabel()
        label.text = "The meaning goes here."
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.tintColor = .eerieBlack
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.16
        self.layer.shadowRadius = 10

        self.addSubview(front)
        front.translatesAutoresizingMaskIntoConstraints = false
        front.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        front.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        front.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        front.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        front.addSubview(termLabel)
        termLabel.translatesAutoresizingMaskIntoConstraints = false
        termLabel.centerXAnchor.constraint(equalTo: front.centerXAnchor).isActive = true
        termLabel.centerYAnchor.constraint(equalTo: front.centerYAnchor).isActive = true
        termLabel.leadingAnchor.constraint(equalTo: front.leadingAnchor, constant: 16).isActive = true
        termLabel.trailingAnchor.constraint(equalTo: front.trailingAnchor, constant: -16).isActive = true
        
        self.addSubview(back)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        back.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        back.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        back.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    
        back.addSubview(meaningLabel)
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        meaningLabel.topAnchor.constraint(equalTo: back.topAnchor, constant: 40).isActive = true
        meaningLabel.leadingAnchor.constraint(equalTo: back.leadingAnchor, constant: 40).isActive = true
        meaningLabel.trailingAnchor.constraint(equalTo: back.trailingAnchor, constant: -40).isActive = true
        
        back.isHidden = true
    }

    @objc public func flip() {
        UIView.transition(with: self, duration: 0.3, options: [.transitionFlipFromTop], animations: {
            self.front.isHidden.toggle()
            self.back.isHidden.toggle()
            self.showMeaning.toggle()
        }, completion: nil)
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flip))
        self.addGestureRecognizer(tapGesture)
    }

    public func configure(term: String, meaning: String) {
        self.termLabel.text = term
        self.meaningLabel.text = meaning
    }

    public func defaultSettings() {
        termLabel.text = "The term goes here"
        meaningLabel.text = "The meaning goes here."
    }
}
