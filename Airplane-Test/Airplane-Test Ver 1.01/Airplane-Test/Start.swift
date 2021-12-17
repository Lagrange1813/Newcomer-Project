//
//  Start.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/11.
//

import UIKit

extension ViewController {
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
}
