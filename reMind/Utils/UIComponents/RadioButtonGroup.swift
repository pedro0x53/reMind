//
//  RadioButtonGroup.swift
//  reMind
//
//  Created by Pedro Sousa on 11/02/21.
//

import UIKit

class RadioButtonGroup: UIStackView {

    var selectedIndex: Int? {
        didSet {
            self.select(at: self.selectedIndex!)
        }
    }

    weak var delegate: RadioButtonGroupDelegate?

    func onClick(_ sender: RadioButton) {
        for radioButton in self.arrangedSubviews {
            if let radioButton = radioButton as? RadioButton {
                radioButton.isChecked = false
            }
        }
        sender.isChecked = true
        self.selectedIndex = self.arrangedSubviews.firstIndex(of: sender)

        if let delegate = self.delegate,
           let index = self.selectedIndex {
            delegate.didSelect(at: index)
        }
    }

    private func select(at index: Int) {
        for radioButton in self.arrangedSubviews {
            if let radioButton = radioButton as? RadioButton {
                radioButton.isChecked = false
            }
        }
        guard let radioButom = self.arrangedSubviews[index] as? RadioButton else { return }
        radioButom.isChecked = true
    }

    func addRadioButton(_ radioButton: RadioButton) {
        radioButton.group = self
        super.addArrangedSubview(radioButton)
    }
}
