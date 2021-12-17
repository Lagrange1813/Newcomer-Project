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
    var enemyPush: UIPushBehavior!
    var animator: UIDynamicAnimator!
    var push: UIPushBehavior!
    var upTimer: Timer?
    var downTimer: Timer?

    // 初始化变量
    let plane = UIImageView()
    var alien: UIImageView!
    var torpedoQueue = Queue<UIImageView>()
    var alienQueue = Queue<UIImageView>()
    var torpedo: UIImageView!
    var location = [Double]()
    var cnt = 0
    var loseCnt = 0
    var currentCnt = 0
    var enemyCnt = 1
    var score: UILabel!
    var loseFlag = false
    var gameView: UIView!
    var startView: UIView!
    var rankView: UIView!
    var result: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStartView()
    }

    override var shouldAutorotate: Bool { false }
}
