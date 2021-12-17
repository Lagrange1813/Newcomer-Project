//
//  Collision.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/11.
//

import UIKit

// 碰撞响应
extension ViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        if fireFlag {
            collision.removeItem(torpedo)
            torpedo.isHidden = true
        }
        if identifier as! String == "back" {
            print("lose")
            loseCnt += 1
            let attach = UIAttachmentBehavior(item: alien, attachedToAnchor: p)
            animator.addBehavior(attach)
            collision.removeItem(alien)
            if loseCnt >= 3 {
                gameView.isHidden = true
                gameView.removeFromSuperview()
                loseResult()
            } else {
                gameView.removeFromSuperview()
                gameStart()
            }
//            print(loseCnt)
        }
    }

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        torpedo.isHidden = true
        collision.removeItem(torpedo)
        cnt += 1
        score.text = String(cnt)
        print(cnt)
    }
}
