//
//  DeckInfoViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

class DeckInfoViewController: UIViewController {

    private let deckInfoView: DeckInfo = DeckInfo()

    private let viewModel: DeckInfoViewModel = DeckInfoViewModel()

    override func loadView() {
        super.loadView()
        self.view = self.deckInfoView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupReviewCard()
    }

    func setDeck(_ deck: Deck) {
        self.viewModel.deck = deck
        self.title = self.viewModel.getTitle()

        var style: CardStyle = .active
        if self.viewModel.getReviewNumber() == 0 {
            style = .disabled
        }
        self.deckInfoView.reviewCard.configure(number: self.viewModel.getReviewNumber(),
                                               themeID: self.viewModel.getThemeID(),
                                               style: style)
        
        self.viewModel.loadDataSource()
        self.deckInfoView.tableView.reloadData()
    }

    private func setupTableView() {
        self.deckInfoView.tableView.delegate = self
        self.deckInfoView.tableView.dataSource = self
    }

    private func setupNavBar() {
        let semiboldWeight = UIImage.SymbolConfiguration(weight: .semibold)

        let editSymbol = UIImage(systemName: "square.and.pencil", withConfiguration: semiboldWeight)
        let editButton = UIBarButtonItem(image: editSymbol,
                                         style: .plain,
                                         target: self,
                                         action: #selector(editAction))

        self.navigationItem.rightBarButtonItems = [editButton]
    }

    @objc private func editAction() {
        let controller = ManageDeckViewController()
        if let deck = self.viewModel.deck {
            controller.setDeck(deck)
        }
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.tintColor = .eerieBlack
        self.present(navController, animated: true, completion: nil)
    }

    private func setupReviewCard() {
        self.deckInfoView.reviewCard.setReviewButtonAction(target: self, action: #selector(startReview))
    }

    @objc private func startReview() {
        if self.viewModel.getReviewNumber() > 0 {
            guard let identifier = self.viewModel.deck?.identifier else { return }
            let controller = ReviewViewController()
            controller.setDeckID(identifier)
            controller.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(controller, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Nothing to review",
                                          message: "There's nothing to review today.",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension DeckInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: WordsTableCell.identifier,
                for: indexPath) as? WordsTableCell
        else {
            let cell = WordsTableCell()
            cell.configure(word: self.viewModel.getWord(for: indexPath.row))
            return cell
        }

        cell.configure(word: self.viewModel.getWord(for: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        65
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = WordsTableHeader()
        header.setAddButtonAction(target: self, action: #selector(addButtonAction))
        return header
    }

    @objc private func addButtonAction() {
        let controller = ManageWordViewController()
        controller.delegate = self
        if let deck = self.viewModel.deck {
            controller.setDeckID(deck.identifier!)
        }
        
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.tintColor = .eerieBlack

        self.navigationController?.present(navController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = ManageWordViewController()
        controller.setCard(self.viewModel.getData(for: indexPath.row))

        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.tintColor = .eerieBlack

        self.navigationController?.present(navController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if self.viewModel.deleteWord(for: indexPath.row) {
                self.deckInfoView.tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                print("Something went wrong when trying to delete the word.")
            }
        }
    }
}

extension DeckInfoViewController: CallbackDelegate {
    func callback(_ result: ResultType) {
        switch result {
        case .success:
            self.viewModel.loadDataSource()
            self.deckInfoView.tableView.reloadData()
        case .failure:
            print("Something went wrong when trying to create the word.")
        }
    }
}
