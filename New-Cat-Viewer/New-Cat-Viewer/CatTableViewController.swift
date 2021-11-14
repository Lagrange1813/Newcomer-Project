//
//  CatTableViewController.swift
//  New-Cat-Viewer
//
//  Created by 张维熙 on 2021/11/14.
//

import SnapKit
import UIKit

class CatTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "猫猫查看器"
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    var cats: [Cat] = [
        Cat(name: "这是第1张猫猫", step: "这是第1张猫猫", image: "001"),
        Cat(name: "这是第2张猫猫", step: "这是第2张猫猫", image: "002"),
        Cat(name: "这是第3张猫猫", step: "这是第3张猫猫", image: "003"),
        Cat(name: "这是第4张猫猫", step: "这是第4张猫猫", image: "004"),
        Cat(name: "这是第5张猫猫", step: "这是第5张猫猫", image: "005"),
        Cat(name: "这是第6张猫猫", step: "这是第6张猫猫", image: "006"),
        Cat(name: "这是第7张猫猫", step: "这是第7张猫猫", image: "007")
    ]
    let cellIdentifier = "datacell"
    enum Section {
        case all
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as UITableViewCell

        cell.textLabel?.text = cats[indexPath.row].name
        cell.imageView?.image = UIImage(named: cats[indexPath.row].image)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ImageViewController()
        viewController.imageName = cats[indexPath.row].image
        navigationController?.pushViewController(viewController, animated: true)
    }
}
