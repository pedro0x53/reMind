//
//  WordsTableCell.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

class WordsTableCell: UITableViewCell {

    public static let identifier: String = "WordsTableCellIdentifier"

    private let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "Word"
        label.tintColor = .eerieBlack
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.backgroundColor = .clear
        self.accessoryType = .disclosureIndicator

        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemGray5
        self.selectedBackgroundView = backgroundView

        self.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18).isActive = true
    }

    public func configure(word: String) {
        self.wordLabel.text = word
    }
}
