//
//  HomeViewController.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    private let home = Home(frame: UIScreen.main.bounds)

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
        setupGestures()
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

    private func setupGestures() {
        setupPanGesture()
        setupSwipeGestures()
    }
}

extension HomeViewController: CallbackDelegate {
    func callback() {
        loadTermsDataSource()
        setupCards()
    }
}

extension HomeViewController {
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        self.home.card.addGestureRecognizer(panGesture)
    }

    private func updateCard() {
        if currentCardIndex == flashCards.count {
            currentCardIndex = 0
        } else if currentCardIndex < 0 {
            currentCardIndex = flashCards.count - 1
        }

        let flashCard = flashCards[currentCardIndex]

        if let term = flashCard.value(forKey: "term") as? String, let meaning = flashCard.value(forKey: "meaning") as? String {
            self.home.card.configure(term: term, meaning: meaning)
        }

        if home.card.showMeaning {
            home.card.flip()
        }

        home.card.transform = .identity
        home.card.center.x = self.view.center.x
        home.card.center.y = self.view.center.y
        
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

    @objc private func panAction(_ gesture: UIPanGestureRecognizer) {
        if let card = gesture.view as? Card {
            let point = gesture.translation(in: view)
            
            card.center = CGPoint(x: view.center.x + point.x, y:  view.center.y + point.y)
            
            let rotationAngle = point.x / view.bounds.width * 0.4
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            if point.x > 0 {
                card.alpha = 1 - point.x / 230

                self.home.rememberLabel.text = "I remembered!"
                self.home.rememberLabel.alpha = point.x / 200
            } else{
                card.alpha = 1 - (point.x * -1) / 230

                self.home.rememberLabel.text = "I forgot!"
                self.home.rememberLabel.alpha = (point.x * -1) / 200
            }
            
            if gesture.state == .ended {
                if (card.center.x > (self.view.bounds.width + 20) || card.center.x < -20)  && flashCards.count > 0 {
                    card.alpha = 0
                    self.currentCardIndex += 1
                    self.updateCard()
                } else {
                    UIView.animate(withDuration: 0.3) {
                        card.center.x = self.view.center.x
                        card.center.y = self.view.center.y
                        card.transform = .identity
                        card.alpha = 1

                        self.home.rememberLabel.alpha = 0
                    }
                }
            }
        }
    }
}

extension HomeViewController {
    private func setupSwipeGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeLeft.direction = .left
        self.home.swipeArea.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeRight.direction = .right
        self.home.swipeArea.addGestureRecognizer(swipeRight)
    }

    @objc private func swipeAction(_ swipe: UISwipeGestureRecognizer) {
        if swipe.state == .ended {
            UIView.animate(withDuration: 0.3, animations: {
                self.home.card.alpha = 0
            })
            currentCardIndex = (swipe.direction == .right) ? currentCardIndex - 1 : currentCardIndex + 1
            updateCard()
        }
    }
}
