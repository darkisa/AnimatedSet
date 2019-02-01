//
//  CardsContainer.swift
//  GraphicalSet
//
//  Created by Darko Mijatovic on 1/16/19.
//  Copyright © 2019 Darko Mijatovic. All rights reserved.
//

import UIKit

class CardsContainer: UIView {
  
  private(set) var grid = Grid(layout: Grid.Layout.aspectRatio(2/3))
  
  override func layoutSubviews() {
    super.layoutSubviews()
    updateSubviews()
  }
  
  func updateSubviews() {
    updateGrid()
    for (i, subView) in subviews.enumerated() {
      UIViewPropertyAnimator.runningPropertyAnimator(
        withDuration: 0.6,
        delay: 0.2,
        options: [],
        animations: {
          subView.frame = self.grid[i]!.insetBy(dx: Constants.dxInset, dy: Constants.dyInset)
          subView.backgroundColor = UIColor.clear
     })
    }
  }
  
  func updateGrid() {
    if grid.cellCount == subviews.count {
      return
    } else {
      grid.cellCount = subviews.count
      grid.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
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