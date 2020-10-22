//
//  WordListViewController.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit
import CoreData

class TermListViewController: UIViewController {

    private let termList = TermList()
    
    private let coreDataManager = CoreDataManager.shared

    private var flashCards: [NSManagedObject] = []

    override func loadView() {
        super.loadView()
        self.view = self.termList
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadWordsDataSource()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        registerTableViewCell()
        self.termList.tableView.dataSource = self
        self.termList.tableView.delegate = self
    }

    private func setupNavBar() {
        self.title = "My Terms"
    }

    private func registerTableViewCell() {
        self.termList.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "termCell")
    }

    private func loadWordsDataSource() {
        self.flashCards = self.coreDataManager.readAllFlashCards()
        self.termList.tableView.reloadData()
    }
}

extension TermListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flashCard = flashCards[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "termCell", for: indexPath)
        cell.textLabel?.text = flashCard.value(forKey: "term") as? String
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let card = flashCards[indexPath.row]
            self.coreDataManager.deleteFlashCard(card)
            self.flashCards.remove(at: indexPath.row)
            self.termList.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EditiTermViewController()
        controller.card = flashCards[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
