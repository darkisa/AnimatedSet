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
  
  func snap(_ item: UIDynamicItem, _ point: CGPoint) {
    let snap = UISnapBehavior(item: item, snapTo: point)
    snap.damping = 0.2
    addChildBehavior(snap)
  }
  
  func addItem(_ item: UIDynamicItem, _ point: CGPoint = CGPoint.zero) {
    itemBehavior.addItem(item)
    snap(item, point)
//    push(item)
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


//private func push(_ item: UIDynamicItem) {
//  let push = UIPushBehavior(items: [item], mode: .instantaneous)
//  push.angle = CGFloat(arc4random_uniform(UInt32(CGFloat.pi)))
//  push.magnitude = 1
//  push.action = { [unowned push, weak self] in
//    self?.removeChildBehavior(push)
//  }
//  //    addChildBehavior(push)
//}
