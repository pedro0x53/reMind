//
//  HomeViewController.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    private let home = Home()

    private var flashCards: [NSManagedObject] = []

    private let coreDataManager = CoreDataManager.shared

    private var currentCardIndex = 0

    override func loadView() {
        super.loadView()
        self.view = self.home
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTermsDataSource()
        setupCards()
        setupGesture()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }

    private func loadTermsDataSource() {
        self.flashCards = self.coreDataManager.readAllFlashCards()
    }

    private func setupNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        let boldWeight = UIImage.SymbolConfiguration(weight: .bold)

        let editImageSymbol = UIImage(systemName: "square.and.pencil", withConfiguration: boldWeight)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: editImageSymbol,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(createNewWord))
    }

    @objc private func createNewWord() {
        let newWordController = NewTermViewController()
        newWordController.delegate = self
        let nav = UINavigationController(rootViewController: newWordController)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }

    private func setupCards() {
        if flashCards.isEmpty {
            self.home.card.defaultSettings()
        } else {
            if currentCardIndex == flashCards.count {
                currentCardIndex = 0
            }
            let card = flashCards[currentCardIndex]
            if let term = card.value(forKey: "term") as? String, let meaning = card.value(forKey: "meaning") as? String {
                self.home.card.configure(term: term, meaning: meaning)
            }
        }
    }
}

extension HomeViewController: CallbackDelegate {
    func callback() {
        loadTermsDataSource()
        setupCards()
    }
}

extension HomeViewController {
    private func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(animate))
        self.home.card.addGestureRecognizer(panGesture)
    }

    private func updateCard() {
        self.currentCardIndex += 1
        if self.currentCardIndex == flashCards.count && flashCards.count > 0 {
            currentCardIndex = 0
        }

        let flashCard = flashCards[currentCardIndex]

        if let term = flashCard.value(forKey: "term") as? String, let meaning = flashCard.value(forKey: "meaning") as? String {
            self.home.card.configure(term: term, meaning: meaning)
        }

        if home.card.showMeaning {
            home.card.flip()
        }

        home.card.center = self.view.center
        home.card.transform = .identity
        
        home.card.alpha = 0
        home.card.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.home.rememberLabel.alpha = 0
        })

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: { [unowned self] in
                self.home.card.transform = .identity
                self.home.card.alpha = 1
        }, completion: nil)
    }

    @objc private func animate(_ gesture: UIPanGestureRecognizer) {
        if let card = gesture.view as? Card {
            let point = gesture.translation(in: view)
            
            card.center = CGPoint(x: view.center.x + point.x, y:  view.center.y + point.y)
            
            let rotationAngle = point.x / view.bounds.width * 0.4
            
            if point.x > 0 {
                self.home.rememberLabel.text = "I remembered!"
            } else {
                self.home.rememberLabel.text = "I forgot!"
            }
            
            self.home.rememberLabel.alpha = (point.x > 0) ? point.x / 200 : (point.x * -1) / 200

            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            card.alpha = (point.x > 0) ? 1 - point.x / 200 : 1 - (point.x * -1) / 200
            
            if gesture.state == .ended {
                if (card.center.x > (self.view.bounds.width + 20) || card.center.x < -20)  && flashCards.count > 0 {
                    card.alpha = 0
                    self.updateCard()
                } else {
                    UIView.animate(withDuration: 0.3) {
                        card.center = self.view.center
                        card.transform = .identity
                        card.alpha = 1

                        self.home.rememberLabel.alpha = 0
                    }
                }
            }
        }
    }
}
