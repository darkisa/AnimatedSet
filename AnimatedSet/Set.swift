//
//  Set.swift
//  Set
//
//  Created by Darko Mijatovic on 12/26/18.
//  Copyright © 2018 Darko Mijatovic. All rights reserved.
//

import Foundation

struct Set {
  
  init(){
    for symbol in Card.Symbol.all {
      for color in Card.Color.all {
        for fill in Card.Fill.all {
          for pipCount in Card.PipCount.all {
            cards.append(Card(symbol: symbol, color: color, fill: fill, pips: pipCount))
          }
        }
      }
    }
    cards.shuffle()
  }
  
  enum SelectedCardsActions {
    case noaction, remove, deselect
  }

  var cards = [Card?]()
  private(set) var score = 0
  lazy var gameSummary = (action: SelectedCardsActions.noaction, selectedCards: [Card]())
  private(set) var selectedCards = [Card]() {
    didSet {
      if selectedCards.count == 3 {
        checkForMatch()
      }
    }
  }
  
  mutating func addToSelectedCards(selectedCard: Card) {
    if !selectedCards.contains(selectedCard) {
      selectedCards.append(selectedCard)
    } else {
      let deselectCardIndex = selectedCards.index(of: selectedCard)!
      selectedCards.remove(at: deselectCardIndex)
    }
  }
  
  mutating func checkForMatch() {
    if selectedCardsMatch() {
      score += 3
      gameSummary.action = .remove
    } else {
      score -= 5
      gameSummary.action = .deselect
    }
    gameSummary.selectedCards = selectedCards
    selectedCards.removeAll()
  }
  
  func selectedCardsMatch() -> Bool {
    let cardOne = selectedCards[0]
    let cardTwo = selectedCards[1]
    let cardThree = selectedCards[2]
    return cardMatch(firstCard: cardOne.symbol, secondCard: cardTwo.symbol, thirdCard: cardThree.symbol) &&
            cardMatch(firstCard: cardOne.pips, secondCard: cardTwo.pips, thirdCard: cardThree.pips) &&
            cardMatch(firstCard: cardOne.color, secondCard: cardTwo.color, thirdCard: cardThree.color) &&
            cardMatch(firstCard: cardOne.fill, secondCard: cardTwo.fill, thirdCard: cardThree.fill)
  }
  
  func cardMatch<T: Equatable>(firstCard: T, secondCard: T, thirdCard: T) -> Bool {
    return (firstCard == secondCard && firstCard == thirdCard) ||
            (firstCard != secondCard && firstCard != thirdCard && secondCard != thirdCard)
  }
}
