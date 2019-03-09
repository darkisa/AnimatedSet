//
//  ConcentrationCard.swift
//  AnimatedSet
//
//  Created by Darko Mijatovic on 3/9/19.
//  Copyright © 2019 Darko Mijatovic. All rights reserved.
//

import Foundation

struct ConcentrationCard: Hashable {
  var isFaceUp = false
  var isMatched = false
  private var identifier: Int
  var hashValue: Int { return identifier }
  static func ==(lhs: ConcentrationCard, rhs: ConcentrationCard) -> Bool {
    return lhs.identifier == rhs.identifier
  }
  
  private static var identifierFactory = 0
  
  private static func getUniqueIdentifier() -> Int {
    identifierFactory += 1
    return identifierFactory
  }
  
  init() {
    self.identifier = ConcentrationCard.getUniqueIdentifier()
  }
}
