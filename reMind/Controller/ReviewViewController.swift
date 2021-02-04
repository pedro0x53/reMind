//
//  ReviewViewController.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit
import CoreData

class ReviewViewController: UIViewController {

    private let review = Review(frame: UIScreen.main.bounds)

    private var flashCards: [NSManagedObject] = []

    private let coreDataManager = CoreDataManager.shared

    private var currentCardIndex = 0

    override func loadView() {
        super.loadView()
        self.view = self.review
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTermsDataSource()
        setupCards()
        setupGestures()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStopButton()
    }

    private func loadTermsDataSource() {
        self.flashCards = self.coreDataManager.readAllFlashCards()
    }

    private func setupStopButton() {
        self.review.stopButton.addTarget(self, action: #selector(stopReviewing), for: .touchUpInside)
    }

    @objc private func stopReviewing() {
        self.dismiss(animated: true, completion: nil)
    }

    private func setupCards() {
        if flashCards.isEmpty {
            currentCardIndex = 0
            self.review.card.defaultSettings()
        } else {
            if currentCardIndex == flashCards.count {
                currentCardIndex = 0
            }
            let card = flashCards[currentCardIndex]
            if let term = card.value(forKey: "term") as? String, let meaning = card.value(forKey: "meaning") as? String {
                self.review.card.configure(term: term, meaning: meaning)
            }
        }
    }

    private func setupGestures() {
        setupPanGesture()
    }
}

extension ReviewViewController: CallbackDelegate {
    func callback() {
        loadTermsDataSource()
        setupCards()
    }
}

extension ReviewViewController {
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        self.review.card.addGestureRecognizer(panGesture)
    }

    private func updateCard() {
        if !flashCards.isEmpty {
            if currentCardIndex == flashCards.count {
                currentCardIndex = 0
            } else if currentCardIndex < 0 {
                currentCardIndex = flashCards.count - 1
            }

            let flashCard = flashCards[currentCardIndex]

            if let term = flashCard.value(forKey: "term") as? String, let meaning = flashCard.value(forKey: "meaning") as? String {
                self.review.card.configure(term: term, meaning: meaning)
            }
        }

        review.card.alpha = 0
        review.card.transform = .identity
        review.card.center.x = self.view.center.x
        review.card.center.y = self.view.center.y
        review.card.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        if review.card.showMeaning {
            review.card.flip()
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.review.rememberLabel.alpha = 0
        })

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: { [unowned self] in
                self.review.card.transform = .identity
                self.review.card.alpha = 1
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

                self.review.rememberLabel.text = "I remembered!"
                self.review.rememberLabel.alpha = point.x / 200
            } else{
                card.alpha = 1 - (point.x * -1) / 230

                self.review.rememberLabel.text = "I forgot!"
                self.review.rememberLabel.alpha = (point.x * -1) / 200
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

                        self.review.rememberLabel.alpha = 0
                    }
                }
            }
        }
    }
}
