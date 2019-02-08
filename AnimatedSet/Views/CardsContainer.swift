//
//  CardsContainer.swift
//  GraphicalSet
//
//  Created by Darko Mijatovic on 1/16/19.
//  Copyright © 2019 Darko Mijatovic. All rights reserved.
//

import UIKit

class CardsContainer: UIView {
  
  lazy var grid = Grid(layout: Grid.Layout.aspectRatio(2/3), frame: cardsContainerRect())
  var cardDelay = Timer()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    grid.frame = cardsContainerRect()
    updateSubviews()
  }
  
  func updateSubviews() {
    for (i, subView) in subviews.enumerated() {
      UIViewPropertyAnimator.runningPropertyAnimator(
        withDuration: 0.6,
        delay: 0,
        options: [],
        animations: {
          subView.frame = self.grid[i]!.insetBy(dx: Constants.dxInset, dy: Constants.dyInset)
     })
    }
  }
  
  func cardsContainerRect() -> CGRect {
    return CGRect(x: Constants.startingX, y: Constants.startingY, width: bounds.width, height: bounds.height)
  }
}

extension CardsContainer {
  private struct Constants {
    static let startingX: CGFloat = 0
    static let startingY: CGFloat = 0
    static let dxInset: CGFloat = 5
    static let dyInset: CGFloat = 5
  }
}
