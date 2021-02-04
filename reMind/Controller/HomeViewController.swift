//
//  NewHomeViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 03/02/21.
//

import UIKit

class HomeViewController: UIViewController {

    private let homeView = Home()

    override func loadView() {
        super.loadView()
        self.view = homeView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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

        let searchSymbol = UIImage(systemName: "magnifyingglass", withConfiguration: semiboldWeight)
        let searchButton = UIBarButtonItem(image: searchSymbol,
                                          style: .plain,
                                          target: self,
                                          action: #selector(shareDeck))

        self.navigationItem.rightBarButtonItems = [plusButton, searchButton]
    }

    @objc private func newDeck() {
        let controller = NewDeckViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.tintColor = .eerieBlack
        self.navigationController?.present(navController, animated: true, completion: nil)
    }

    @objc private func shareDeck() {
        let alert = UIAlertController(title: "Oops!", message: "We are still working on this functionality.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    private func setupCollectionView() {
        self.homeView.decksCollection.delegate = self
        self.homeView.decksCollection.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DeckInfoViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
   
}
