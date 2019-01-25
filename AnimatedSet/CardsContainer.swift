//
//  CardsContainer.swift
//  GraphicalSet
//
//  Created by Darko Mijatovic on 1/16/19.
//  Copyright © 2019 Darko Mijatovic. All rights reserved.
//

import UIKit

class CardsContainer: UIView {
  
  private var grid = Grid(layout: Grid.Layout.aspectRatio(2/3))
  
  override func layoutSubviews() {
    super.layoutSubviews()
    getGridDimensions(numberOfSubviews: subviews.count)
    for (i, subView) in subviews.enumerated() {
      subView.frame = grid[i]!.insetBy(dx: Constants.dxInset, dy: Constants.dyInset)
      subView.backgroundColor = UIColor.clear
    }
  }
  
  private func getGridDimensions(numberOfSubviews: Int) {
    grid.cellCount = numberOfSubviews
    grid.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
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
