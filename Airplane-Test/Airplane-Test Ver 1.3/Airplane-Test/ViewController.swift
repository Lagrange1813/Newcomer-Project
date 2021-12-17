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

    
}
