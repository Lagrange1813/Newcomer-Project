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
        if let currentTorpedo = torpedo {
            currentTorpedo.isHidden = true
            collision.removeItem(currentTorpedo)
        }
        if identifier as! String == "back" {
            print("lose")
            loseCnt += 1
            
            if joyStick.tracking {
                joyStick.tracking = false
                joyStick.velocityLoop.invalidate()
            }
            
            let attach = UIAttachmentBehavior(item: alien, attachedToAnchor: p)
            animator.addBehavior(attach)
            
            while !alienQueue.isEmpty() {
                let temp = alienQueue.dequeue()
                collision.removeItem(temp)
            }
            
            if loseCnt >= 3 {
                gameView.isHidden = true
                gameView.removeFromSuperview()
                loseResult()
                SqlOperator.insertRecord(cnt)
            } else {
                gameView.removeFromSuperview()
                gameStart()
            }
        }
    }

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        if let currentTorpedo = torpedo {
            currentTorpedo.isHidden = true
            collision.removeItem(currentTorpedo)
        }
        
        if torpedo != nil {
            cnt += 1
            currentCnt += 1
            if currentCnt >= 25 {
                levelUP(location)
                currentCnt = 0
                enemyCnt += 1
            }
            score.text = String(cnt)
            print(cnt)
        }
    }
}
