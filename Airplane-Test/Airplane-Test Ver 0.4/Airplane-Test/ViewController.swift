//
//  ViewController.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/2.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    var collision: UICollisionBehavior!
    var animtor: UIDynamicAnimator!
    var push: UIPushBehavior!
    
    let plane = UIImageView()
    var time = Date()
    var torpedo: UIImageView!
    var location = [Double]()
    var cnt = 0
    var score: UILabel!
    var loseFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        configureController()
        configurePlane()
        fetchLocation()
        configureEnemy()
    }

    override var shouldAutorotate: Bool {
        return false
    }

    func configureBackground() {
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        view.backgroundColor = .black
        score = UILabel(frame: CGRect(x: view.frame.width-40, y: 20, width: 20, height: 20))
        score.text = "0"
        score.textColor = .white
        view.addSubview(score)
    }
    
    func configureController() {
        let height = view.frame.height/2
        let width = view.frame.width
        
        let upButton = UIButton(frame: CGRect(x: 0, y: 0, width: height, height: height))
        upButton.setImage(UIImage(systemName: "arrowtriangle.up.circle"), for: .normal)
        upButton.setImage(UIImage(systemName: "arrowtriangle.up.circle.fill"), for: .highlighted)
        upButton.addTarget(self, action: #selector(controlPlaneUP), for: .touchDown)
        
        let downButton = UIButton(frame: CGRect(x: 0, y: height, width: height, height: height))
        downButton.setImage(UIImage(systemName: "arrowtriangle.down.circle"), for: .normal)
        downButton.setImage(UIImage(systemName: "arrowtriangle.down.circle.fill"), for: .highlighted)
        downButton.addTarget(self, action: #selector(controlPlaneDown), for: .touchUpInside)
        
        let fireButton = UIButton(frame: CGRect(x: width - height, y: height, width: height, height: height))
        fireButton.setImage(UIImage(systemName: "atom"), for: .normal)
        fireButton.addTarget(self, action: #selector(controlPlaneFire), for: .touchUpInside)
        
        view.addSubview(upButton)
        view.addSubview(downButton)
        view.addSubview(fireButton)
        
        animtor = UIDynamicAnimator(referenceView: view)
        collision = UICollisionBehavior()
    }
    
    func configurePlane() {
        let plane_width = 50.0
        let plane_height = 50.0
        let x = view.frame.size.height * 0.75 * 0.5
        let y = view.frame.size.height/2.0 - plane_height/2.0
        
        plane.image = UIImage(named: "shuttle")
        plane.frame = CGRect(x: x, y: y, width: plane_width, height: plane_height)
        
        view.addSubview(plane)
    }
    
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
    
    @objc func controlPlaneFire() {
        let current = Date()
//        print(current.timeIntervalSince1970)
        let newTorpedo = UIImageView()
        torpedo = newTorpedo
        if current.timeIntervalSince1970 - time.timeIntervalSince1970 > 0.3 {
            time = current
            
            let torpedo_width = 20.0
            let torpedo_height = 20.0
            let x = plane.frame.origin.x + plane.frame.width + 10.0
            let y = plane.frame.origin.y + plane.frame.height/2.0 - torpedo_height/2.0
//            print((x, y))
            
            torpedo.image = UIImage(named: "torpedo")
            torpedo.frame = CGRect(x: x, y: y, width: torpedo_width, height: torpedo_height)
            
            view.addSubview(torpedo)
            
            push = UIPushBehavior(items: [newTorpedo], mode: .instantaneous)
            push.setAngle(0, magnitude: 1.0)
            animtor.addBehavior(push)
            
            collision.addItem(newTorpedo)
        }
    }
    
    func fetchLocation() {
        let y = plane.frame.origin.y + plane.frame.height/2.0
        location.append(y)
        for x in 1 ... 10 {
            let currentUP = y + CGFloat(x) * plane.frame.height
            let currentDo = y - CGFloat(x) * plane.frame.height
            if currentDo > 0 {
                location.append(currentDo)
            }
            if currentUP < view.frame.height {
                location.append(currentUP)
            }
        }
        location.sort()
    }
    
    func configureEnemy() {
        let alien = UIImageView()
        let width = view.frame.width - 100.0
        alien.image = UIImage(named: "alien2")
        alien.frame = CGRect(x: width, y: 137.5 - 20.0, width: 50.0, height: 40.0)
        view.addSubview(alien)
        
        collision.addItem(alien)
        collision.translatesReferenceBoundsIntoBoundary = false
        collision.collisionMode = .everything
        collision.collisionDelegate = self
        collision.addBoundary(withIdentifier: "upside" as NSCopying,
                              from: CGPoint(x: 0, y: 0),
                              to: CGPoint(x: 10000, y: 0))
        collision.addBoundary(withIdentifier: "downside" as NSCopying,
                              from: CGPoint(x: 0, y: view.frame.height),
                              to: CGPoint(x: 10000, y: view.frame.height))
        collision.addBoundary(withIdentifier: "back" as NSCopying,
                              from: CGPoint(x: 0, y: 0),
                              to: CGPoint(x: 0, y: view.frame.height))
        collision.addBoundary(withIdentifier: "front" as NSCopying,
                              from: CGPoint(x: 1000, y: 0),
                              to: CGPoint(x: 1000, y: view.frame.height))
        animtor.addBehavior(collision)
        
        let enemyPush = UIPushBehavior(items: [alien], mode: .continuous)
        enemyPush.setAngle(Double.pi, magnitude: 0.1)
        animtor.addBehavior(enemyPush)
    }
}

extension ViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        if identifier as! String == "back" {
//            controlPlaneFire()
        } else {
            collision.removeItem(torpedo)
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
