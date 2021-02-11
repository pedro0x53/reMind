//
//  DeckInfoViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

class DeckInfoViewController: UIViewController {

    private let deckInfoView: DeckInfo = DeckInfo()

    let viewModel: DeckInfoViewModel = DeckInfoViewModel()

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

    private func setupTableView() {
        self.deckInfoView.tableView.delegate = self
        self.deckInfoView.tableView.dataSource = self
    }

    private func setupNavBar() {
        self.title = "Deck Name"

        let semiboldWeight = UIImage.SymbolConfiguration(weight: .semibold)

        let editSymbol = UIImage(systemName: "square.and.pencil", withConfiguration: semiboldWeight)
        let editButton = UIBarButtonItem(image: editSymbol,
                                         style: .plain,
                                         target: self,
                                         action: #selector(editAction))

        let shareSymbol = UIImage(systemName: "square.and.arrow.up", withConfiguration: semiboldWeight)
        let shareButton = UIBarButtonItem(image: shareSymbol,
                                          style: .plain,
                                          target: self,
                                          action: #selector(shareAction))

        self.navigationItem.rightBarButtonItems = [editButton, shareButton]
    }

    @objc private func shareAction() {
        let alert = UIAlertController(title: "Oops!", message: "We are still working on this functionality.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    @objc private func editAction() {
        let controller = EditDeckViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.tintColor = .eerieBlack
        self.present(navController, animated: true, completion: nil)
    }

    private func setupReviewCard() {
        self.deckInfoView.reviewCard.configure()
        self.deckInfoView.reviewCard.setReviewButtonAction(target: self, action: #selector(startReview))
    }

    @objc private func startReview() {
        let controller = ReviewViewController()
        controller.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(controller, animated: true, completion: nil)
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
            cell.configure()
            return cell
        }

        cell.configure()
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
        let controller = NewTermViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.tintColor = .eerieBlack
        self.navigationController?.present(navController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = EditiTermViewController()
//        controller.card = self.viewModel.getData(for: indexPath.row)

        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.tintColor = .eerieBlack
        self.navigationController?.present(navController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if self.viewModel.deleteWord(for: indexPath.row) {
                self.deckInfoView.tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                print("Something went wrong when trying to delete Word.")
            }
        }
    }
}
