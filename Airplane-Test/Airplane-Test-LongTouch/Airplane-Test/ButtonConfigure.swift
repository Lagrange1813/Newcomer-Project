//
//  ButtonConfigure.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/11.
//

import UIKit

extension ViewController {
    @objc func controlPlaneUP() {
        if plane.frame.origin.y > 0 {
            UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
                self.plane.center.y -= self.plane.frame.height
            }, completion: nil)
        }
    }

    @objc func controlPlaneDown() {
        let current = plane.frame.origin.y + plane.frame.height
        let limit = view.frame.height
        if current < limit {
            UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
                self.plane.center.y += self.plane.frame.height
            }, completion: nil)
        }
    }

    @objc func upLongTouch(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            print("Long Press")
            upTimer = Timer(timeInterval: 0.1, repeats: true) { _ in
                if self.plane.frame.origin.y > 0 {
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
                        self.plane.center.y -= 30
                    }, completion: nil)
                }
            }
            RunLoop.current.add((upTimer)!, forMode: .default)
        }
        if gesture.state == UIGestureRecognizer.State.ended {
            print("Long Press Ended")
            upTimer?.invalidate()
        }
    }

    @objc func downLongTouch(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            print("Long Press")
            downTimer = Timer(timeInterval: 0.1, repeats: true) { _ in
                let current = self.plane.frame.origin.y + self.plane.frame.height
                let limit = self.view.frame.height
                if current < limit {
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
                        self.plane.center.y += 30
                    }, completion: nil)
                }
            }
            RunLoop.current.add((downTimer)!, forMode: .default)
        }
        if gesture.state == UIGestureRecognizer.State.ended {
            print("Long Press Ended")
            downTimer?.invalidate()
        }
    }

    @objc func controlPlaneFire() {
        let newTorpedo = UIImageView()
        torpedo = newTorpedo

        let torpedo_width = 20.0
        let torpedo_height = 20.0
        let x = plane.frame.origin.x + plane.frame.width + 10.0
        let y = plane.frame.origin.y + plane.frame.height / 2.0 - torpedo_height / 2.0

        torpedo.image = UIImage(named: "torpedo")
        torpedo.frame = CGRect(x: x, y: y, width: torpedo_width, height: torpedo_height)

        gameView.addSubview(torpedo)

        push = UIPushBehavior(items: [newTorpedo], mode: .instantaneous)
        push.setAngle(0, magnitude: 1.0)
        animator.addBehavior(push)

        collision.addItem(torpedo)

        torpedoQueue.enqueue(newTorpedo)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            let lastTorpedo = self.torpedoQueue.dequeue()
            lastTorpedo.isHidden = true
            self.collision.removeItem(lastTorpedo)
        }
    }
}
