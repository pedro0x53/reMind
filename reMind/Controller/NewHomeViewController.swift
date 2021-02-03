//
//  NewHomeViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 03/02/21.
//

import UIKit

class NewHomeViewController: UIViewController {

    private let newhomeView = NewHome()

    override func loadView() {
        self.view = newhomeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView()
    }

    private func setupNavBar() {
        self.title = "Decks"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let semiboldWeight = UIImage.SymbolConfiguration(weight: .semibold)

        let plusSymbol = UIImage(systemName: "plus", withConfiguration: semiboldWeight)
        let plusButton = UIBarButtonItem(image: plusSymbol,
                                         style: .plain,
                                         target: self,
                                         action: #selector(newDeck))

        let shareSymbol = UIImage(systemName: "magnifyingglass", withConfiguration: semiboldWeight)
        let shareButton = UIBarButtonItem(image: shareSymbol,
                                          style: .plain,
                                          target: self,
                                          action: #selector(shareDeck))

        self.navigationItem.rightBarButtonItems = [plusButton, shareButton]
    }

    @objc private func newDeck() {
        print("New Deck Tapped!")
    }

    @objc private func shareDeck() {
        print("Share Deck Tapped!")
    }

    private func setupCollectionView() {
        self.newhomeView.decksCollection.delegate = self
        self.newhomeView.decksCollection.dataSource = self
    }
}

extension NewHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DecksCollectionCell.identifier, for: indexPath) as? DecksCollectionCell
        else {
            return UICollectionViewCell()
        }

        cell.configure()

        return cell
    }
    

   
}
