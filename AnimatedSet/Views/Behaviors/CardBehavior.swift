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
    behavior.elasticity = 1.0
    behavior.resistance = 0
    return behavior
  }()
  
  private func push(_ item: UIDynamicItem) {
    let push = UIPushBehavior(items: [item], mode: .instantaneous)
    push.angle = (-2*CGFloat.pi / 3)
    push.magnitude = 1
    push.action = { [unowned push, weak self] in
      self?.removeChildBehavior(push)
    }
    addChildBehavior(push)
  }
  
  func addItem(_ item: UIDynamicItem) {
    itemBehavior.addItem(item)
    push(item)
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
