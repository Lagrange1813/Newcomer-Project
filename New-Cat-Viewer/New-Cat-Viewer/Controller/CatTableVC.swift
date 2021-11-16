//
//  CatTableViewController.swift
//  New-Cat-Viewer
//
//  Created by 张维熙 on 2021/11/14.
//

import SnapKit
import UIKit

class CatTableVC: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    
    // MARK: - Load data
//    var cats: [Cat] = [
//        Cat(name: "这是第1张猫猫", step: "这是第1张猫猫", image: "001"),
//        Cat(name: "这是第2张猫猫", step: "这是第2张猫猫", image: "002"),
//        Cat(name: "这是第3张猫猫", step: "这是第3张猫猫", image: "003"),
//        Cat(name: "这是第4张猫猫", step: "这是第4张猫猫", image: "004"),
//        Cat(name: "这是第5张猫猫", step: "这是第5张猫猫", image: "005"),
//        Cat(name: "这是第6张猫猫", step: "这是第6张猫猫", image: "006"),
//        Cat(name: "这是第7张猫猫", step: "这是第7张猫猫", image: "007")
//    ]
    var catNames = ["这是第1张猫猫", "这是第2张猫猫", "这是第3张猫猫", "这是第4张猫猫", "这是第5张猫猫", "这是第6张猫猫", "这是第7张猫猫"]
    var catImages = ["001", "002", "003", "004", "005", "006", "007"]
    let cellIdentifier = "datacell"
    enum Section {
        case all
    }
    
    
    // MARK: - Configure view
    func configureTableView() {
        title = "猫猫查看器"
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.rowHeight = 140
        showDataSource()
    }
    
    func showDataSource() {
        tableView.dataSource = dataSource
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(catNames, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String >{
        let cellIdentifier = "datacell"
        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, catName in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                cell.textLabel?.text = catName
                cell.imageView?.image = UIImage(named: self.catImages[indexPath.row])
                cell.imageView?.layer.cornerRadius = 15
                cell.imageView?.clipsToBounds = true
                return cell
            }
        )
        return dataSource
    }
    
    lazy var dataSource = configureDataSource()
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cats.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as UITableViewCell
//
//        cell.textLabel?.text = cats[indexPath.row].name
//        cell.imageView?.image = UIImage(named: cats[indexPath.row].image)
//
//        return cell
//    }
    
    
    // MARK: - Function
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ImageVC()
        viewController.imageName = catImages[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
