//
//  SceneConfigure.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/11.
//

import UIKit

extension ViewController {
    // 配置游戏主 View
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

        gameView.addSubview(score)

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
        for x in 0 ..< loseCnt {
            hearts[x].image = UIImage(systemName: "heart")
        }
    }

    // 配置控制器
    func configureController() {
        let velocityMultiplier: CGFloat = 0.12
        let height = view.frame.height / 2
        let width = view.frame.width
        let size = 100

        joyStick = JoyStick(x: 50.0,
                            y: view.frame.height - 50.0 - Double(size),
                            size: size)
        gameView.addSubview(joyStick)

        joyStick.handler = { [unowned self] data in
            self.plane.center = CGPoint(x: plane.center.x + (data.velocity.x * velocityMultiplier),
                                        y: plane.center.y + (data.velocity.y * velocityMultiplier))

            let upSide = plane.frame.origin.y
            let downSide = plane.frame.origin.y + plane.frame.height
            let leftSide = plane.frame.origin.x
            let rightSide = plane.frame.origin.x + plane.frame.width

            if upSide < 0 {
                plane.frame.origin.y = 0
            } else if leftSide < 0 {
                plane.frame.origin.x = 0
            } else if downSide > view.frame.height {
                plane.frame.origin.y = view.frame.height - plane.frame.height
            } else if rightSide > view.frame.width {
                plane.frame.origin.x = view.frame.width - plane.frame.width
            }
        }

        let fireButton = UIButton(frame: CGRect(x: width - height, y: height, width: height, height: height))
        fireButton.setImage(UIImage(systemName: "atom"), for: .normal)
        fireButton.addTarget(self, action: #selector(controlPlaneFire), for: .touchUpInside)

        gameView.addSubview(fireButton)

        animator = UIDynamicAnimator(referenceView: gameView)
        collision = UICollisionBehavior()
    }

    // 配置飞机
    func configurePlane() {
        let plane_width = 50.0
        let plane_height = 50.0
        let x = view.frame.size.height * 0.75 * 0.5
        let y = view.center.y - plane_height / 2.0

        plane.image = UIImage(named: "shuttle")
        plane.frame = CGRect(x: x, y: y, width: plane_width, height: plane_height)

        gameView.addSubview(plane)
        gameView.clipsToBounds = true

        location = fetchLocation()
    }

    // 配置 Alien
    func configureEnemy() {
        for _ in 0 ..< enemyCnt {
            levelUP(location)
        }

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
    }
}

struct Aliens {
    var width: Double!
    var height: Double!
    var image: UIImage!
}

enum AliensToCome: Int {
    case alien = 0
    case asteroid1
    case asteroid2
}

extension ViewController {
    // 获取飞机位置，用来调整 alien 随机生成位置
    func fetchLocation() -> [Double] {
        let y = view.center.y
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
        return location.sorted()
    }
}

func randomMinus() -> Int {
    let flag = arc4random()%2
    if flag == 0 { return -1 }
    if flag == 1 { return +1 }
    return 0
}

extension ViewController {
    func levelUP(_ location: [Double]) {
        alien = UIImageView()

        let width = view.frame.width - 100.0

        var enemy = Aliens()

        let random = arc4random()%3
        let test = AliensToCome(rawValue: Int(random))

        switch test {
        case .alien:
            enemy.width = 50.0
            enemy.height = 40.0
            enemy.image = UIImage(named: "alien2")
        case .asteroid1:
            enemy.width = 50.0
            enemy.height = 40.0
            enemy.image = UIImage(named: "alien")
        case .asteroid2:
            enemy.width = 50.0
            enemy.height = 40.0
            enemy.image = UIImage(named: "alien3")
        case .none:
            break
        }

        let minus_sign = randomMinus()
        let pixelJitter = Double(Int(arc4random()%5) * minus_sign)
        let randomIndex = Int(arc4random()%UInt32(location.count))
        let testLocation = location[randomIndex] - enemy.height / 2.0 + pixelJitter
//        let debugLocation = view.center.y - 20.0

        alien.image = enemy.image
        alien.frame = CGRect(x: width + pixelJitter, y: testLocation, width: enemy.width, height: enemy.height)
        gameView.addSubview(alien)
        alienQueue.enqueue(alien)
        collision.addItem(alien)

        if enemyCnt < 4 {
            enemyPush = UIPushBehavior(items: [alien], mode: .continuous)
            enemyPush.setAngle(Double.pi, magnitude: 0.05)
            animator.addBehavior(enemyPush)
        } else {
            enemyPush = UIPushBehavior(items: [alien], mode: .instantaneous)
            enemyPush.setAngle(Double.pi, magnitude: 0.15)
            animator.addBehavior(enemyPush)
        }
    }
}
