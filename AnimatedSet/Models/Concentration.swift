//
//  Concentration.swift
//  AnimatedSet
//
//  Created by Darko Mijatovic on 3/9/19.
//  Copyright © 2019 Darko Mijatovic. All rights reserved.
//

import Foundation

struct Concentration {
  private(set) var cards = [ConcentrationCard]()
  private var indexOfOneAndOnlyFaceUpCard: Int? {
    get {
      return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
    }
    set {
      for index in cards.indices {
        cards[index].isFaceUp = (index == newValue)
      }
    }
  }
  
  private(set) var flipCount = 0
  private var seenCards = Set<Int>()
  private(set) var score = 0
  
  init(numberOfPairsOfCards: Int) {
    assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) cannot be negative")
    for _ in 0..<numberOfPairsOfCards {
      let card = ConcentrationCard()
      cards += [card, card]
    }
    cards.shuffle()
  }
  
  mutating func resetGame() {
    indexOfOneAndOnlyFaceUpCard = nil
    flipCount = 0
    score = 0
    for index in cards.indices {
      cards[index].isFaceUp = false
      cards[index].isMatched = false
    }
    cards.shuffle()
  }
  
  mutating func chooseCard(at index: Int){
    assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
    flipCount += 1
    if !cards[index].isMatched {
      if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
        if cards[matchIndex] == cards[index] {
          cards[matchIndex].isMatched = true
          cards[index].isMatched = true
          score += 2
        }
        cards[index].isFaceUp = true
      } else {
        indexOfOneAndOnlyFaceUpCard = index
        if seenCards.contains(index) {
          score -= 1
        } else {
          seenCards.insert(index)
        }
      }
    }
  }
}

extension Collection {
  var oneAndOnly: Element? {
    return count == 1 ? first : nil
  }
}
