//
//  PlayingCardView.swift
//  GraphicalSet
//
//  Created by Darko Mijatovic on 1/9/19.
//  Copyright © 2019 Darko Mijatovic. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
  
  var card = Card()
  var selected = false { didSet(newValue) { cardSelected() }
  }
  
  override func draw(_ rect: CGRect) {
    let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    roundedRect.addClip()
    UIColor.white.setFill()
    roundedRect.fill()
    let path = UIBezierPath()
    drawSymbol(of: card, path: path)
    setColor(of: card)
    setFill(of: card, path: path)
    path.addClip()
    path.lineWidth = 3.0
    path.stroke()
    layer.cornerRadius = cornerRadius
  }
  
  private func cardSelected() {
    if selected {
      layer.borderWidth = 3
      layer.borderColor = UIColor.blue.cgColor
    } else {
      layer.borderWidth = 0
    }
  }
  
  private func drawSymbol(of card: Card, path: UIBezierPath) {
    switch card.symbol {
    case .triangle: drawTriangle(path: path, pipCount: card.pips.rawValue)
    case .square: drawSquare(path: path, pipCount: card.pips.rawValue)
    case .circle: drawCircle(path: path, pipCount: card.pips.rawValue)
    }
  }
  
  private func setColor(of card: Card) {
    switch card.color {
    case .red:
      UIColor.red.withAlphaComponent(0.5).setFill()
      UIColor.red.setStroke()
    case .green:
      UIColor.green.withAlphaComponent(0.5).setFill()
      UIColor.green.setStroke()
    case .purple:
      UIColor.purple.withAlphaComponent(0.5).setFill()
      UIColor.purple.setStroke()
    }
  }
  
  private func setFill(of card: Card, path: UIBezierPath) {
    switch card.fill {
    case .solid: path.fill()
    case .striped:
      for i in stride(from: 0, through: Int(bounds.maxY), by: 5){
        path.move(to: CGPoint(x: 0, y: i))
        path.addLine(to: CGPoint(x: bounds.maxX, y: CGFloat(i)))
      }
    case .open: break
    }
  }
}

extension PlayingCardView {
  private struct SizeRatio {
    static let pipWidthToBoundsRatio: CGFloat = 0.45
    static let pipHeightToBoundsRatio: CGFloat = 0.20
    static let pipVerticalCenterToBoundsRatio = [1: [0.5], 2: [0.33, 0.66], 3: [0.25, 0.5, 0.75]]
    static let cornerRadiusToBoundsHeight: CGFloat = 0.06
  }
  
  private var cornerRadius: CGFloat {
    return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
  }
  
  private func drawTriangle(path: UIBezierPath, pipCount: Int) {
    let centerRatios = SizeRatio.pipVerticalCenterToBoundsRatio[pipCount]!
    let width = bounds.width * SizeRatio.pipWidthToBoundsRatio
    let height = bounds.height * SizeRatio.pipHeightToBoundsRatio
    for ratio in centerRatios {
      let center = bounds.height * CGFloat(ratio)
      path.move(to: CGPoint(x: bounds.midX - width / 2, y: center + height / 2))
      path.addLine(to: CGPoint(x: bounds.midX, y: center - height / 2))
      path.addLine(to: CGPoint(x: bounds.midX + width / 2, y: center + height / 2))
      path.close()
    }
  }
  
  private func drawSquare(path: UIBezierPath, pipCount: Int) {
    let centerRatios = SizeRatio.pipVerticalCenterToBoundsRatio[pipCount]!
    let width = bounds.width * SizeRatio.pipWidthToBoundsRatio
    let height = bounds.height * SizeRatio.pipHeightToBoundsRatio
    for ratio in centerRatios {
      let center = bounds.height * CGFloat(ratio)
      path.move(to: CGPoint(x: bounds.midX - width / 2, y: center - height / 2))
      path.addLine(to: CGPoint(x: bounds.midX + width / 2, y: center - height / 2))
      path.addLine(to: CGPoint(x: bounds.midX + width / 2, y: center + height / 2))
      path.addLine(to: CGPoint(x: bounds.midX - width / 2, y: center + height / 2))
      path.close()
    }
  }
  
  private func drawCircle(path: UIBezierPath, pipCount: Int) {
    let centerRatios = SizeRatio.pipVerticalCenterToBoundsRatio[pipCount]!
    for ratio in centerRatios {
      path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.height * CGFloat(ratio)),
                radius: bounds.width * SizeRatio.pipWidthToBoundsRatio / 3,
                startAngle: 0,
                endAngle: 2*CGFloat.pi,
                clockwise: true)
    }
  }
}
