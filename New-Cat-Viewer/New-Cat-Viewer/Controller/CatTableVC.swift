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
    var cats: [Cat] = [
        Cat(name: "这是第1张猫猫", step: "这是第1张猫猫", image: "001"),
        Cat(name: "这是第2张猫猫", step: "这是第2张猫猫", image: "002"),
        Cat(name: "这是第3张猫猫", step: "这是第3张猫猫", image: "003"),
        Cat(name: "这是第4张猫猫", step: "这是第4张猫猫", image: "004"),
        Cat(name: "这是第5张猫猫", step: "这是第5张猫猫", image: "005"),
        Cat(name: "这是第6张猫猫", step: "这是第6张猫猫", image: "006"),
        Cat(name: "这是第7张猫猫", step: "这是第7张猫猫", image: "007")
    ]
//    var catNames = ["这是第1张猫猫", "这是第2张猫猫", "这是第3张猫猫", "这是第4张猫猫", "这是第5张猫猫", "这是第6张猫猫", "这是第7张猫猫"]
//    var catImages = ["001", "002", "003", "004", "005", "006", "007"]
    let cellIdentifier = "datacell"
    enum Section {
        case all
    }
    
    
    // MARK: - Configure view
    func configureTableView() {
        title = "猫猫查看器"
        tableView?.register(CatCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.rowHeight = 140
//        tableView.dataSource = self
//        tableView.delegate = self
        showDataSource()
    }
    
    func showDataSource() {
        tableView.dataSource = dataSource
        var snapshot = NSDiffableDataSourceSnapshot<Section, Cat>()
        snapshot.appendSections([.all])
        snapshot.appendItems(cats, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Cat>{
        let cellIdentifier = "datacell"
        let dataSource = UITableViewDiffableDataSource<Section, Cat>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, cat in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CatCell
                cell.set(cat: cat)
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
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! CatCell
//        cell.set(cat: cats[indexPath.row])
////        cell.nameLabel.text = catNames[indexPath.row]
////        cell.imgView.image = UIImage(named: catImages[indexPath.row])
//
//        return cell
//    }
    
    
    // MARK: - Function
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ImageVC()
        viewController.imageName = cats[indexPath.row].image
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Get the selected cat
        guard let cat = self.dataSource.itemIdentifier(for: indexPath)
        else {
            return UISwipeActionsConfiguration()
        }
        // Delete
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([cat])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            completionHandler(true)
        }
        // Share
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "看看这只猫猫！"
            let activityController: UIActivityViewController
            if let imageToShare = UIImage(named: cat.image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil) }else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
        }
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        // Configure both actions as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }
}
