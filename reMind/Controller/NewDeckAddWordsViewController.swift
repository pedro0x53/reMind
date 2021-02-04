//
//  NewDeckAddWordsViewController.swift
//  reMind
//
//  Created by Pedro Sousa on 04/02/21.
//

import UIKit

class NewDeckAddWordsViewController: UIViewController {

    private let addWordsView = NewDeckAddWords()

    private var deletedRows: Int = 0

    override func loadView() {
        super.loadView()
        self.view = self.addWordsView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupNavBar() {
        self.title = "Add Words"

        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveAction))

    }

    @objc private func saveAction() {
        print("Save Tapped!")
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    private func setupTableView() {
        self.addWordsView.tableView.dataSource = self
        self.addWordsView.tableView.delegate = self
    }
}

extension NewDeckAddWordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10 - deletedRows
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell Tapped at row \(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let card = flashCards[indexPath.row]
//            self.coreDataManager.deleteFlashCard(card)
//            self.flashCards.remove(at: indexPath.row)
            deletedRows += 1
            self.addWordsView.tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
