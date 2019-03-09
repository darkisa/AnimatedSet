//
//  ConcentrationViewController.swift
//  AnimatedSet
//
//  Created by Darko Mijatovic on 3/9/19.
//  Copyright © 2019 Darko Mijatovic. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
  private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
  var numberOfPairsOfCards: Int { return (cardButtons.count + 1 ) / 2 }
  lazy var selectedTheme = Int.random(in: 0..<(themes.count))
  
  @IBOutlet private weak var flipCountLabel: UILabel!
  @IBOutlet private var cardButtons: [UIButton]!
  @IBOutlet private weak var score: UILabel!
  
  @IBAction func newGame(_ sender: UIButton) {
    game.resetGame()
    selectedTheme = Int.random(in: 0..<(themes.count))
    emoji.removeAll()
    updateViewFromModel()
  }
  
  @IBAction func touchCard(_ sender: UIButton) {
    if let cardNumber = cardButtons.index(of: sender) {
      game.chooseCard(at: cardNumber)
      updateViewFromModel()
    }
  }
  
  func updateViewFromModel() {
    for index in cardButtons.indices {
      let button = cardButtons[index]
      let card = game.cards[index]
      if card.isFaceUp {
        button.setTitle(emoji(for: card), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      } else {
        button.setTitle("", for: UIControl.State.normal)
        button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
      }
    }
    flipCountLabel.text = "Flips: \(game.flipCount)"
    score.text = "Score: \(game.score)"
  }
  
  var themes = [0: ["🇦🇷","🇷🇸","🇺🇸","🇩🇪","🇬🇷","🇮🇹","🇪🇸","🇫🇷"],
                1: ["🐶","🐥","🐵","🐼","🐸","🦁","🦋","🐴"],
                2: ["😘","😜","😮","😝","😬","🤗","😎","🤓"]]
  
  var emoji = [ConcentrationCard:String]()
  
  func emoji(for card: ConcentrationCard) -> String {
    if emoji[card] == nil, themes[selectedTheme]!.count > 0 {
      emoji[card] = themes[selectedTheme]!.remove(at: themes[selectedTheme]!.count.arc4random)
    }
    return emoji[card] ?? "?"
  }
}

extension Int {
  var arc4random: Int {
    if self > 0 {
      return Int(arc4random_uniform(UInt32(self)))
    } else if self < 0 {
      return -Int(arc4random_uniform(UInt32(abs(self))))
    } else {
      return 0
    }
  }
}
