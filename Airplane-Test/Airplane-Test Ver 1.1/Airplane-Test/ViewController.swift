//
//  ViewController.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/2.
//

import UIKit

class ViewController: UIViewController {
    // 初始化 UIKit Dynamics
    var collision: UICollisionBehavior!
    var animator: UIDynamicAnimator!
    var push: UIPushBehavior!

    // 初始化变量
    let plane = UIImageView()
    var alien: UIImageView!
    var time = Date()
    var torpedo: UIImageView!
    var location = [Double]()
    var cnt = 0
    var score: UILabel!
    var loseFlag = false
    var fireFlag = false
//    var startButton: UIButton!
    var gameView: UIView!
    var startView: UIView!
    var rankView: UIView!
    var result: UIView!
    var loseCnt = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStartView()
    }

    override var shouldAutorotate: Bool { false }

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
}
