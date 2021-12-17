//
//  Start.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/11.
//

import UIKit

extension ViewController {
    @objc func configureStartView() {
        view.backgroundColor = .black
        startView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: view.frame.width,
                                        height: view.frame.height))
        view.addSubview(startView)
        configureStartButton()
    }
    
    func configureStartButton() {
        let buttonWidth = 100.0
        let buttonHeight = 20.0
        let x = view.center.x - buttonWidth/2.0
        let y = view.center.y - buttonHeight/2.0
        let startButton = UIButton(frame: CGRect(x: x, y: y-25, width: buttonWidth, height: buttonHeight))
        startButton.setTitle("开始游戏", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitleColor(.gray, for: .highlighted)
        startButton.addTarget(self, action: #selector(gameStart), for: .touchUpInside)
        
        let rankButton = UIButton(frame: CGRect(x: x, y: y+25, width: buttonWidth, height: buttonHeight))
        rankButton.setTitle("排行榜", for: .normal)
        rankButton.setTitleColor(.white, for: .normal)
        rankButton.setTitleColor(.gray, for: .highlighted)
        rankButton.addTarget(self, action: #selector(showRank), for: .touchUpInside)
        
        startView.addSubview(startButton)
        startView.addSubview(rankButton)
    }

    @objc func gameStart() {
//        startButton.isHidden = true
        startView.removeFromSuperview()
        location = []
        torpedo = nil
        configureGameView()
        configureBackground()
        configureController()
        configurePlane()
//        fetchLocation()
        configureEnemy()
    }
    
    @objc func showRank() {
        startView.removeFromSuperview()
        configureRankView()
    }
    
    func configureRankView() {
        rankView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: view.frame.width,
                                        height: view.frame.height))
        
        let goButton = UIButton(frame: CGRect(x: 10, y: 10, width: 60, height: 40))
        goButton.setTitle("返回", for: .normal)
        goButton.setTitleColor(.white, for: .normal)
        goButton.setTitleColor(.gray, for: .highlighted)
        goButton.addTarget(self, action: #selector(goBackToStartView), for: .touchUpInside)
        rankView.addSubview(goButton)
        
        let x = view.center.x
        let y = view.center.y
        let width = 400.0
        let height = 20.0
        
        let resultList = SqlOperator.getRecord()
        
        let first = UILabel(frame: CGRect(x: x-width/2.0, y: y-height/2.0-50.0, width: width, height: height))
        let second = UILabel(frame: CGRect(x: x-width/2.0, y: y-height/2.0, width: width, height: height))
        let third = UILabel(frame: CGRect(x: x-width/2.0, y: y-height/2.0+50.0, width: width, height: height))
        let ranks = [first, second, third]
        
        for x in 0...2 {
            let score: Int = resultList[x]["score"] as! Int
            let time: String = resultList[x]["time"] as! String
            let texts = String(format: "第%d名\t分数 %4d\t时间 %@", x+1, score, time)
            ranks[x].text = texts
            ranks[x].textColor = .white
            print(score)
            print(time)
        }
        
        
        rankView.addSubview(first)
        rankView.addSubview(second)
        rankView.addSubview(third)
        
        
        view.addSubview(rankView)
//        configureRankList()
    }
    
    @objc func goBackToStartView() {
        rankView.removeFromSuperview()
        configureStartView()
    }
}
