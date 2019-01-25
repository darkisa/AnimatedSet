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
  @IBAction func dealThreeMoreCards(_ sender: UISwipeGestureRecognizer) {
    for _ in 0..<3 {
      addCardSubviewToCardContainer()
    }
  }
  
  @IBOutlet weak var score: UILabel!
  private var game = Set()
  
  @IBAction private func newGame() {
    game = Set()
    removeExistingSubviews()
    for _ in 0..<12 {
      addCardSubviewToCardContainer()
    }
  }
  
  private func removeExistingSubviews() {
    for view in cardsContainer.subviews {
      view.removeFromSuperview()
    }
  }
  
  private func addCardSubviewToCardContainer() {
    if game.cards.isEmpty { return }
    let card = game.cards.popLast()
    let cardView = PlayingCardView()
    addTapGesture(view: cardView)
    cardView.card = card!!
    cardsContainer.addSubview(cardView)
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    newGame()
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
