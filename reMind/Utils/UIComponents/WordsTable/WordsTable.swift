//
//  WordsTable.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

class WordsTable: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupLayout()
        registerCell()
        registerHeader()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.separatorStyle = .none
    }

    private func registerCell() {
        self.register(WordsTableCell.self, forCellReuseIdentifier: WordsTableCell.identifier)
    }

    private func registerHeader() {
        self.register(WordsTableHeader.self, forHeaderFooterViewReuseIdentifier: WordsTableHeader.identifier)
    }
}
