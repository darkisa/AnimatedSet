//
//  CardBehavior.swift
//  AnimatedSet
//
//  Created by Darko Mijatovic on 1/27/19.
//  Copyright © 2019 Darko Mijatovic. All rights reserved.
//

import UIKit

class CardBehavior: UIDynamicBehavior {
  
  static var count = 1
  
  lazy var itemBehavior: UIDynamicItemBehavior = {
    let behavior = UIDynamicItemBehavior()
    behavior.allowsRotation = true
    behavior.elasticity = 0.4
    behavior.resistance = 0
    return behavior
  }()
  
  lazy var collisionBehavior: UICollisionBehavior = {
    let collision = UICollisionBehavior()
    collision.translatesReferenceBoundsIntoBoundary = true
    return collision
  }()
  
  private func push(_ item: UIDynamicItem) {
    let push = UIPushBehavior(items: [item], mode: .instantaneous)
    push.angle = CGFloat(arc4random_uniform(UInt32(CGFloat.pi)))
    push.magnitude = 10
    push.action = { [unowned push, weak self] in
      self?.removeChildBehavior(push)
    }
    addChildBehavior(push)
  }
  
  func addItem(_ item: UIDynamicItem) {
    itemBehavior.addItem(item)
    collisionBehavior.addItem(item)
    push(item)
  }
  
  func removeItem(_ item: UIDynamicItem) {
    itemBehavior.removeItem(item)
    collisionBehavior.removeItem(item)
  }
  
  func addSnapBehavior(_ item: UIDynamicItem, point: CGPoint) {
    let snap = UISnapBehavior(item: item, snapTo: point)
    snap.action = {
      item.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi / 2)
    }
    addChildBehavior(snap)
  }
  
  override init() {
    super.init()
    addChildBehavior(itemBehavior)
    addChildBehavior(collisionBehavior)
  }

  convenience init(in animator: UIDynamicAnimator) {
    self.init()
    animator.addBehavior(self)
  }
}
