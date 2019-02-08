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
    var delay = 0.0
    for _ in 0..<3 {
      if let cardView = addCardSubviewToCardContainer() {
        dealCard(card: cardView, delay: delay)
        delay += 0.08
      }
    }
  }
  
  // Animation
  lazy var animator = UIDynamicAnimator(referenceView: cardsContainer)
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
      _ = addCardSubviewToCardContainer()
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
  
  @objc private func addCardSubviewToCardContainer() -> PlayingCardView? {
    if game.cards.isEmpty { return nil }
    let card = game.cards.popLast()!
    let cardView = PlayingCardView()
    let deckOfCardsFrame = deckOfCards.convert(deckOfCards.frame, to: cardsContainer)
    addTapGesture(view: cardView)
    cardView.card = card!
    cardView.frame = deckOfCardsFrame
    cardView.backgroundColor = UIColor.clear
    if numberOfCardsInPlay > 12 {
      cardView.addRotationAnimation()
    }
    cardsContainer.addSubview(cardView)
    return cardView
  }
  
  private func dealCard(card: PlayingCardView, delay: Double) {
    let gridPosition = cardsContainer.subviews.endIndex - 1
    UIViewPropertyAnimator.runningPropertyAnimator(
      withDuration: 0.6,
      delay: delay,
      options: [],
      animations: {
        card.frame = self.cardsContainer.grid[gridPosition]!.insetBy(dx: 5, dy: 5)
      }
    )
  }
  
  private func updateView() {
    let gameSummary = game.gameSummary
    let selectedCards = game.gameSummary.selectedCards
    switch gameSummary.action {
    case .remove:
      for card in selectedCards {
        removeCard(card: card)
      }
    case .deselect:
      for card in selectedCards {
        deselectCards(card: card)
      }
    case .noaction: break
    }
    game.gameSummary.action = .noaction
    game.gameSummary.selectedCards = []
    score.text = "Score: \(game.score)"
  }
  
  private func removeCard(card: Card) {
    guard let subView = cardsContainer.subviews.first(where: { ($0 as? PlayingCardView)?.card == card }) else {
      return
    }
    cardBehavior.addItem(subView)
//    subView.removeFromSuperview()
  }
  
  private func deselectCards(card: Card) {
    guard let subView = cardsContainer.subviews.first(where: { ($0 as? PlayingCardView)?.card == card }) as? PlayingCardView else {
      return
    }
    subView.selected = false
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
