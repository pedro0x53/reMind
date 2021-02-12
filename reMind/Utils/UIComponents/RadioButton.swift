//
//  RadioButton.swift
//  reMind
//
//  Created by Pedro Sousa on 11/02/21.
//

import UIKit

class RadioButton: UIButton {

    weak var group: RadioButtonGroup?

    var isChecked: Bool = false {
        didSet {
            if self.isChecked {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                    self.selectView.alpha = 1
                })
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                    self.selectView.alpha = 0
                })
            }
            self.selectView.isHidden = !isChecked
        }
    }

    private let selectView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.userActivity = .none
        return view
    }()

    init(width: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: width).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClick))
        self.addGestureRecognizer(tapGesture)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = self.frame.width / 2

        self.addSubview(selectView)
        self.selectView.isHidden = true
        selectView.translatesAutoresizingMaskIntoConstraints = false
        selectView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.65).isActive = true
        selectView.heightAnchor.constraint(equalToConstant: self.frame.width * 0.65).isActive = true
        selectView.layer.cornerRadius = (self.frame.width * 0.8) / 2
        selectView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        selectView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }

    @objc func onClick() {
        self.group?.onClick(self)
    }
}
