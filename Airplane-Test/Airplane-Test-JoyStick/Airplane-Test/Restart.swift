//
//  Restart.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/11.
//

import UIKit

// 失败页面-重新开始
extension ViewController {
    func loseResult() {
        result = UIView(frame: CGRect(x: 0,
                                      y: 0,
                                      width: view.frame.width,
                                      height: view.frame.height))
        let textWidth = 130.0
        let textHeight = 20.0
        let x = view.center.x - textWidth/2.0
        let y = view.center.y - textHeight/2.0
        let gameResult = UILabel(frame: CGRect(x: x, y: y - 50, width: textWidth, height: textHeight))
        gameResult.text = "游戏得分：\(cnt)"
        gameResult.textColor = .white

        result.addSubview(gameResult)

        let restartButton = UIButton(frame: CGRect(x: x, y: y, width: textWidth, height: textHeight))
        restartButton.setTitle("重新开始", for: .normal)
        restartButton.setTitleColor(.white, for: .normal)
        restartButton.setTitleColor(.gray, for: .highlighted)
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)

        result.addSubview(restartButton)

        let backButton = UIButton(frame: CGRect(x: x, y: y + 50, width: textWidth, height: textHeight))
        backButton.setTitle("返回主页", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.setTitleColor(.gray, for: .highlighted)
        backButton.addTarget(self, action: #selector(backIndex), for: .touchUpInside)

        result.addSubview(backButton)

        view.addSubview(result)
    }

    @objc func restartGame() {
        result.removeFromSuperview()
        cnt = 0
        loseCnt = 0
        enemyCnt = 1
        gameStart()
    }

    @objc func backIndex() {
        result.removeFromSuperview()
        cnt = 0
        loseCnt = 0
        enemyCnt = 1
        configureStartView()
    }
}
