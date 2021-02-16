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

    var hasEdits: Bool = false

    weak var delegate: HomeDelegate?

    override func loadView() {
        super.loadView()
        self.view = self.deckInfoView
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent && self.hasEdits {
            self.delegate?.updateCollection(with: self.viewModel.deck)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupReviewCardAction()
    }

    func setDeck(_ deck: Deck) {
        self.viewModel.deck = deck
        self.title = self.viewModel.getTitle()

        setupReviewCardLayout()
        
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

        self.navigationItem.rightBarButtonItem = editButton
    }

    @objc private func editAction() {
        let controller = ManageDeckViewController()
        controller.deckInfoDelegate = self

        guard let deck = self.viewModel.deck else { return }
        controller.setDeck(deck)

        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.tintColor = .eerieBlack
        self.present(navController, animated: true, completion: nil)
    }

    private func setupReviewCardLayout() {
        self.deckInfoView.reviewCard.configure(number: self.viewModel.getReviewNumber(),
                                               themeID: self.viewModel.getThemeID())
    }

    private func setupReviewCardAction() {
        self.deckInfoView.reviewCard.setReviewButtonAction(target: self, action: #selector(startReview))
    }

    @objc private func startReview() {
        if self.viewModel.getReviewNumber() > 0 {
            guard let identifier = self.viewModel.deck?.identifier else { return }
            let controller = ReviewViewController()
            controller.setDeckID(identifier)
            controller.theme = self.viewModel.getThemeID()
            controller.modalPresentationStyle = .overFullScreen

            controller.delegate = self

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

        self.viewModel.editingIndex = nil
        
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.tintColor = .eerieBlack

        self.navigationController?.present(navController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        self.viewModel.editingIndex = indexPath.row

        let controller = ManageWordViewController()
        controller.setCard(self.viewModel.getData(for: indexPath.row))
        controller.delegate = self

        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.tintColor = .eerieBlack

        self.navigationController?.present(navController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.editingIndex = indexPath.row
            self.viewModel.deleteFromDataSource()
            self.viewModel.editingIndex = nil

            self.setupReviewCardLayout()
            self.deckInfoView.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension DeckInfoViewController: DeckInfoDelegate {
    func updateTable(with item: Card?) {
        if let card = item {
            if let index = self.viewModel.editingIndex {
                self.viewModel.updateDataSource(with: card)
                self.viewModel.editingIndex = nil
                self.deckInfoView.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            } else {
                self.viewModel.appendToDataSource(card)
                self.deckInfoView.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
            }
        } else {
            guard let index = self.viewModel.editingIndex else { return }
            self.viewModel.deleteFromDataSource()
            self.viewModel.editingIndex = nil
            self.deckInfoView.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }

    func updateInfo(with deck: Deck) {
        self.hasEdits = true
        self.viewModel.deck = deck
        self.title = viewModel.getTitle()
    }

    func deleted() {
        self.delegate?.updateCollection(with: nil)
        self.navigationController?.popViewController(animated: false)
    }

    func updateReviewCard() {
        self.setupReviewCardLayout()
    }

    func error() {
        
    }
}
