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
        let gameResult = UILabel(frame: CGRect(x: x, y: y - 25, width: textWidth, height: textHeight))
        gameResult.text = "游戏得分：\(cnt)"
        gameResult.textColor = .white

        result.addSubview(gameResult)

        let restartButton = UIButton(frame: CGRect(x: x, y: y + 25, width: textWidth, height: textHeight))
        restartButton.setTitle("重新开始", for: .normal)
        restartButton.setTitleColor(.white, for: .normal)
        restartButton.setTitleColor(.gray, for: .highlighted)
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)

        result.addSubview(restartButton)

        view.addSubview(result)
    }

    @objc func restartGame() {
        result.removeFromSuperview()
        cnt = 0
        loseCnt = 0
        gameStart()
    }
}
