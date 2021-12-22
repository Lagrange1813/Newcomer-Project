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
            let attach = UIAttachmentBehavior(item: alien, attachedToAnchor: p)
            animator.addBehavior(attach)
            
            while !alienQueue.isEmpty() {
                let temp = alienQueue.dequeue()
                collision.removeItem(temp)
            }
            
//            collision.removeItem(alien)
            if loseCnt >= 3 {
                gameView.isHidden = true
                gameView.removeFromSuperview()
                loseResult()
                SqlOperator.insertRecord(cnt)
//                SqlOperator.getRecord()
            } else {
                gameView.removeFromSuperview()
                gameStart()
            }
//            print(loseCnt)
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
            if currentCnt >= 10 {
                levelUP(location)
                currentCnt = 0
                enemyCnt += 1
            }
            score.text = String(cnt)
            print(cnt)
        }
//        cnt += 1
//        score.text = String(cnt)
//        print(cnt)
    }
}
