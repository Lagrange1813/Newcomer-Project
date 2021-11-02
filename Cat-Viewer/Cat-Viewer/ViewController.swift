//
//  ViewController.swift
//  Cat-Viewer
//
//  Created by Lagrange1813 on 2021/11/2.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var textNames = ["这是第1张猫猫", "这是第2张猫猫", "这是第3张猫猫", "这是第4张猫猫", "这是第5张猫猫", "这是第6张猫猫", "这是第7张猫猫", "这是第8张猫猫", "这是第9张猫猫", "这是第10张猫猫", "这是第11张猫猫", "这是第12张猫猫", "这是第13张猫猫", "这是第14张猫猫", "这是第15张猫猫", "这是第16张猫猫"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 16
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = textNames[indexPath.row]
        cell.imageView?.image = UIImage(named: "001")
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

