//
//  NewHomeViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 03/02/21.
//

import UIKit

class HomeViewController: UIViewController {

    private let homeView = Home()

    private let viewModel = HomeViewModel()

    override func loadView() {
        super.loadView()
        self.view = homeView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        self.viewModel.editingIndex = nil
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

        self.navigationItem.rightBarButtonItem = plusButton
    }

    @objc private func newDeck() {
        let controller = ManageDeckViewController()
        controller.homeDelegate = self
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.tintColor = .eerieBlack
        self.navigationController?.present(navController, animated: true, completion: nil)
    }

    private func setupCollectionView() {
        self.homeView.decksCollection.delegate = self
        self.homeView.decksCollection.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(
                withReuseIdentifier: DecksCollectionCell.identifier, for: indexPath) as? DecksCollectionCell
        else {
            let item = DecksCollectionCell()
            item.configure(name: self.viewModel.getName(for: indexPath.item),
                           theme: self.viewModel.getTheme(for: indexPath.item))
            return item
        }

        item.configure(name: self.viewModel.getName(for: indexPath.item),
                       theme: self.viewModel.getTheme(for: indexPath.item))

        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DeckInfoViewController()
        controller.delegate = self
        self.viewModel.editingIndex = indexPath.item
        let deck = self.viewModel.data(for: indexPath.item)
        controller.setDeck(deck)
        self.navigationController?.pushViewController(controller, animated: true)
    }
   
}

extension HomeViewController: HomeDelegate {
    func updateCollection(with item: Deck?) {
        if let deck = item {
            if let index = self.viewModel.editingIndex {
                self.viewModel.updateDataSource(with: deck)
                self.homeView.decksCollection.reloadItems(at: [IndexPath(row: index, section: 0)])
            } else {
                self.viewModel.appendToDataSource(deck)
                self.homeView.decksCollection.insertItems(at: [IndexPath(row: 0, section: 0)])
            }
        } else {
            guard let index = self.viewModel.editingIndex else { return }
            self.viewModel.deleteFromDataSource()
            self.homeView.decksCollection.deleteItems(at: [IndexPath(row: index, section: 0)])
        }
    }

    func error() {
        
    }
}
