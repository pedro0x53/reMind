//
//  DecksCollection.swift
//  reMind
//
//  Created by Pedro Sousa on 03/02/21.
//

import UIKit

class DecksCollection: UICollectionView {

    private let layout: UICollectionViewFlowLayout = {
        let itemWidth = CGFloat((UIScreen.main.bounds.width - 60) / 2)

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.05)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .vertical
        return layout
    }()

    init() {
        super.init(frame: .zero, collectionViewLayout: self.layout)
        setupLayout()
        self.register(DecksCollectionCell.self, forCellWithReuseIdentifier: DecksCollectionCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
}
