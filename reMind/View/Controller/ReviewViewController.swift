//
//  ReviewViewController.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit

class ReviewViewController: UIViewController {

    private let review = Review(frame: UIScreen.main.bounds)

    private let viewModel = ReviewViewModel()

    public weak var delegate: CallbackDelegate?

    private var currentCardIndex = 0

    override func loadView() {
        super.loadView()
        self.view = self.review
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCards()
        setupGestures()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStopButton()
    }

    func setDeckID(_ deckID: String) {
        self.viewModel.deckID = deckID
    }

    private func setupStopButton() {
        self.review.stopButton.addTarget(self, action: #selector(stopReviewing), for: .touchUpInside)
    }

    @objc private func stopReviewing() {
        self.dismiss(animated: true, completion: nil)
    }

    private func setupCards() {
        if let content = viewModel.getNexCardContent() {
            self.review.card.configure(word: content.word, meaning: content.meaning)
        }
    }

    private func setupGestures() {
        setupPanGesture()
    }
}

extension ReviewViewController {
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        self.review.card.addGestureRecognizer(panGesture)
    }

    private func updateCard() {
        if let content = viewModel.getNexCardContent() {
            self.review.card.configure(word: content.word, meaning: content.meaning)
        } else {
            let alert = UIAlertController(title: "Review Completed!",
                                          message: "You completed today's review.",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
                self.delegate?.callback(.success)
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
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
        if let card = gesture.view as? SwipeCard {
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
                if (card.center.x > (self.view.bounds.width + 20) || card.center.x < -20)  /* && flashCards.count > 0*/ {
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
