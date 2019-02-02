//
//  ViewController.swift
//  Set
//
//  Created by Darko Mijatovic on 12/26/18.
//  Copyright © 2018 Darko Mijatovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var cardsContainer: CardsContainer!
  @IBAction func dealThreeMoreCards(_ sender: UITapGestureRecognizer) {
    numberOfCardsInPlay += 3
    for _ in 0..<3 {
      addCardSubviewToCardContainer()
    }
//      if let cardView = subView as? PlayingCardView { cardView.addRotationAnimation() }
  }
  
  // Animation
  lazy var animator = UIDynamicAnimator(referenceView: view)
  lazy var cardBehavior = CardBehavior(in: animator)
  
  // Set game
  @IBOutlet weak var score: UILabel!
  private var game = Set()
  @IBOutlet weak var deckOfCards: PlayingCardView!
  @IBOutlet weak var matchedCards: PlayingCardView!
  private var numberOfCardsInPlay = 12 {
    didSet {
      cardsContainer.grid.updateGrid(newCellCount: numberOfCardsInPlay)
    }
  }
  
  @IBAction private func newGame() {
    game = Set()
    removeExistingSubviews()
    numberOfCardsInPlay = 12
    for _ in 0..<numberOfCardsInPlay {
      addCardSubviewToCardContainer()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    deckOfCards.isFaceUp = false
    matchedCards.isFaceUp = false
    newGame()
  }
  
  private func removeExistingSubviews() {
    for view in cardsContainer.subviews {
      view.removeFromSuperview()
    }
  }
  
  private func addCardSubviewToCardContainer() {
    if game.cards.isEmpty { return }
    let indexOfLastSubview = cardsContainer.subviews.endIndex
    let card = game.cards.popLast()!
    let cardView = PlayingCardView()
    let gridFrame = cardsContainer.grid[indexOfLastSubview]!
    let deckOfCardsPoint = deckOfCards.convert(deckOfCards.frame, to: view).origin
    addTapGesture(view: cardView)
    cardView.card = card!
    cardView.frame = CGRect(origin: deckOfCardsPoint, size: gridFrame.size)
    cardView.backgroundColor = UIColor.clear
    cardsContainer.addSubview(cardView)
    cardBehavior.addItem(cardView, gridFrame.origin)
  }
  
  private func updateView() {
    let gameSummary = game.gameSummary
    let selectedCards = game.gameSummary.selectedCards
    switch gameSummary.action {
    case .remove: removeCards(cards: selectedCards)
    case .deselect: deselectCards(cards: selectedCards)
    case .noaction: break
    }
    game.gameSummary.action = .noaction
    game.gameSummary.selectedCards = []
    score.text = "Score: \(game.score)"
  }
  
  private func removeCards(cards: [Card]) {
    for card in cards {
      let subView = cardsContainer.subviews.first(where: { ($0 as? PlayingCardView)?.card == card })
      subView?.removeFromSuperview()
    }
  }
  
  private func deselectCards(cards: [Card]) {
    for card in cards {
      let subView = cardsContainer.subviews.first(where: { ($0 as? PlayingCardView)?.card == card }) as? PlayingCardView
      subView?.selected = false
    }
  }
  
  private func addTapGesture(view: PlayingCardView) {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectCard))
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func selectCard(sender: UITapGestureRecognizer) {
    if let view = sender.view as? PlayingCardView {
      view.selected = view.selected == true ? false : true
      game.addToSelectedCards(selectedCard: view.card)
    }
    updateView()
  }

}

extension ViewController {
  
}


