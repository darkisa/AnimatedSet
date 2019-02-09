//
//  CardBehavior.swift
//  AnimatedSet
//
//  Created by Darko Mijatovic on 1/27/19.
//  Copyright © 2019 Darko Mijatovic. All rights reserved.
//

import UIKit

class CardBehavior: UIDynamicBehavior {
  
  lazy var itemBehavior: UIDynamicItemBehavior = {
    let behavior = UIDynamicItemBehavior()
    behavior.allowsRotation = true
    behavior.elasticity = 0.4
    behavior.resistance = 0
    return behavior
  }()
  
  private func collision(_ item: UIDynamicItem) {
    let collision = UICollisionBehavior(items: [item])
    collision.translatesReferenceBoundsIntoBoundary = true
    addChildBehavior(collision)
  }
  
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
    collision(item)
    push(item)
  }
  
  func addSnapBehavior(_ item: UIDynamicItem, frame: CGRect) {
     let snap = UISnapBehavior(item: item, snapTo: frame.origin)
     addChildBehavior(snap)
  }
  
  override init() {
    super.init()
    addChildBehavior(itemBehavior)
  }

  convenience init(in animator: UIDynamicAnimator) {
    self.init()
    animator.addBehavior(self)
  }
}
