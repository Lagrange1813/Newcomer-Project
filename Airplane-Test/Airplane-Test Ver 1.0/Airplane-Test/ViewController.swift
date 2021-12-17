//
//  ViewController.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/2.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    
    // 初始化变量
    var collision: UICollisionBehavior!
    var animator: UIDynamicAnimator!
    var push: UIPushBehavior!

    let plane = UIImageView()
    var alien: UIImageView!
    var time = Date()
    var torpedo: UIImageView!
    var location = [Double]()
    var cnt = 0
    var score: UILabel!
    var loseFlag = false
    var fireFlag = false
    var startButton: UIButton!
    var gameView: UIView!
    var result: UIView!
    var loseCnt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStartButton()
    }

    override var shouldAutorotate: Bool { false }

    func configureStartButton() {
        let buttonWidth = 100.0
        let buttonHeight = 100.0
        let x = view.center.x - buttonWidth/2.0
        let y = view.center.y - buttonHeight/2.0
        startButton = UIButton(frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight))
        startButton.setTitle("开始游戏", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitleColor(.gray, for: .highlighted)
        startButton.addTarget(self, action: #selector(gameStart), for: .touchUpInside)
        view.addSubview(startButton)
    }
    
    @objc func gameStart() {
        startButton.isHidden = true
        configureGameView()
        configureBackground()
        configureController()
        configurePlane()
//        fetchLocation()
        configureEnemy()
    }
    
    @objc func restartGame() {
        result.removeFromSuperview()
        cnt = 0
        loseCnt = 0
        gameStart()
    }
    
    func configureGameView() {
        gameView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: view.frame.width,
                                        height: view.frame.height))
        view.addSubview(gameView)
    }
    
    // 配置背景和其他基础项
    func configureBackground() {
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        gameView.backgroundColor = .black
        score = UILabel(frame: CGRect(x: view.frame.width - 60, y: 20, width: 40, height: 20))
        score.text = String(cnt)
        score.textColor = .white
        let heart1 = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 22))
        let heart2 = UIImageView(frame: CGRect(x: 45, y: 10, width: 30, height: 22))
        let heart3 = UIImageView(frame: CGRect(x: 80, y: 10, width: 30, height: 22))
        
        heart1.image = UIImage(systemName: "heart.fill")
        heart2.image = UIImage(systemName: "heart.fill")
        heart3.image = UIImage(systemName: "heart.fill")
        
        gameView.addSubview(heart1)
        gameView.addSubview(heart2)
        gameView.addSubview(heart3)
        
        let hearts = [heart1, heart2, heart3]
        for x in 0..<loseCnt {
            hearts[x].image = UIImage(systemName: "heart")
        }
        gameView.addSubview(score)
    }

    // 配置控制器
    func configureController() {
        let height = view.frame.height / 2
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

        gameView.addSubview(upButton)
        gameView.addSubview(downButton)
        gameView.addSubview(fireButton)

        animator = UIDynamicAnimator(referenceView: gameView)
        collision = UICollisionBehavior()

    }

    // 配置飞机
    func configurePlane() {
        let plane_width = 50.0
        let plane_height = 50.0
        let x = view.frame.size.height * 0.75 * 0.5
        let y = view.frame.size.height / 2.0 - plane_height / 2.0

        plane.image = UIImage(named: "shuttle")
        plane.frame = CGRect(x: x, y: y, width: plane_width, height: plane_height)

        gameView.addSubview(plane)
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
        if fireFlag {
            collision.removeItem(torpedo)}
        let current = Date()
//        print(current.timeIntervalSince1970)
        let newTorpedo = UIImageView()
        torpedo = newTorpedo
        fireFlag = true
        if current.timeIntervalSince1970 - time.timeIntervalSince1970 > 0.5 {
            time = current

            let torpedo_width = 20.0
            let torpedo_height = 20.0
            let x = plane.frame.origin.x + plane.frame.width + 10.0
            let y = plane.frame.origin.y + plane.frame.height / 2.0 - torpedo_height / 2.0
//            print((x, y))

            torpedo.image = UIImage(named: "torpedo")
            torpedo.frame = CGRect(x: x, y: y, width: torpedo_width, height: torpedo_height)

            gameView.addSubview(torpedo)

            push = UIPushBehavior(items: [newTorpedo], mode: .instantaneous)
            push.setAngle(0, magnitude: 1.0)
            animator.addBehavior(push)

            collision.addItem(torpedo)
            
        }
    }

    // （暂时无用）获取飞机位置，用来调整 alien 随机生成位置
//    func fetchLocation() {
//        let y = plane.frame.origin.y + plane.frame.height / 2.0
//        location.append(y)
//        for x in 1...10 {
//            let currentUP = y + CGFloat(x) * plane.frame.height
//            let currentDo = y - CGFloat(x) * plane.frame.height
//            if currentDo > 0 {
//                location.append(currentDo)
//            }
//            if currentUP < view.frame.height {
//                location.append(currentUP)
//            }
//        }
//        location.sort()
//    }

    // 配置 Alien
    func configureEnemy() {
        alien = UIImageView()
        let width = view.frame.width - 100.0
        alien.image = UIImage(named: "alien2")
        alien.frame = CGRect(x: width, y: 137.5 - 20.0, width: 50.0, height: 40.0)
        gameView.addSubview(alien)

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
//        collision.boundary(withIdentifier: "back").
        collision.addBoundary(withIdentifier: "front" as NSCopying,
                from: CGPoint(x: 1000, y: 0),
                to: CGPoint(x: 1000, y: view.frame.height))
        animator.addBehavior(collision)

        let enemyPush = UIPushBehavior(items: [alien], mode: .continuous)
        enemyPush.setAngle(Double.pi, magnitude: 0.1)
        animator.addBehavior(enemyPush)
    }
    
    func loseResult() {
        result = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.frame.width,
                                          height: view.frame.height))
        let textWidth = 100.0
        let textHeight = 20.0
        let x = view.center.x - textWidth/2.0
        let y = view.center.y - textHeight/2.0
        let gameResult = UILabel(frame: CGRect(x: x, y: y-25, width: textWidth, height: textHeight))
        gameResult.text = "游戏得分：\(cnt)"
        gameResult.textColor = .white
        
        result.addSubview(gameResult)
        
        let restartButton = UIButton(frame: CGRect(x: x, y: y+25, width: textWidth, height: textHeight))
        restartButton.setTitle("重新开始", for: .normal)
        restartButton.setTitleColor(.white, for: .normal)
        restartButton.setTitleColor(.gray, for: .highlighted)
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        
        result.addSubview(restartButton)

        view.addSubview(result)
    }
}

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
