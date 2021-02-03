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
        layout.estimatedItemSize = CGSize(width: itemWidth, height: 200)
        layout.minimumLineSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        return layout
    }()

    init() {
        super.init(frame: .zero, collectionViewLayout: self.layout)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
