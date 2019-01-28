//
//  Card.swift
//  Set
//
//  Created by Darko Mijatovic on 12/26/18.
//  Copyright © 2018 Darko Mijatovic. All rights reserved.
//

import Foundation

struct Card {
  
  init() {
    self.symbol = .triangle
    self.color = .red
    self.fill = .solid
    self.pips = .one
  }
  
  init(symbol: Symbol, color: Color, fill: Fill, pips: PipCount) {
    self.symbol = symbol
    self.color = color
    self.fill = fill
    self.pips = pips
  }
  
  let symbol: Symbol, color: Color, fill: Fill, pips: PipCount
  
  enum Symbol {
    case triangle, square, circle
    
    static let all = [Symbol.triangle, .square, .circle]
  }
  
  enum PipCount: Int {
    case one = 1, two, three
    
    static let all = [PipCount.one, .two, .three]
  }
  
  enum Color {
    case red, green, purple
    
    static let all = [Color.red, .green, .purple]
  }
  
  enum Fill {
    case solid, striped, open
    
    static let all = [Fill.solid, .striped, .open]
  }
}

extension Card: Equatable {
  static func == (lhs: Card, rhs: Card) -> Bool {
    return
      lhs.color == rhs.color &&
      lhs.symbol == rhs.symbol &&
      lhs.fill == rhs.fill &&
      lhs.pips == rhs.pips
  }
}
