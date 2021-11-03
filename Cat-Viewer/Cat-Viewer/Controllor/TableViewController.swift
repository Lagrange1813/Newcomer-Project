//
//  TableViewController.swift
//  Cat-Viewer
//
//  Created by Lagrange1813 on 2021/11/3.
//

import UIKit

class TableViewController: UITableViewController {
    
    lazy var dataSource = configureDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Cat>()
        snapshot.appendSections([.all])
        snapshot.appendItems(cats, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    var cats:[Cat] = [
        Cat(name: "这是第1张猫猫", step: "这是第1张猫猫", image: "001"),
        Cat(name: "这是第2张猫猫", step: "这是第2张猫猫", image: "002"),
        Cat(name: "这是第3张猫猫", step: "这是第3张猫猫", image: "003"),
        Cat(name: "这是第4张猫猫", step: "这是第4张猫猫", image: "004"),
        Cat(name: "这是第5张猫猫", step: "这是第5张猫猫", image: "005"),
        Cat(name: "这是第6张猫猫", step: "这是第6张猫猫", image: "006"),
        Cat(name: "这是第7张猫猫", step: "这是第7张猫猫", image: "007")
        ]
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Cat>{
        let cellIdentifier = "datacell"
        
        let dataSource = DiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, cat in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
                
                cell.nameLabel.text = cat.name
                cell.stepLabel.text = cat.step
                cell.thumbnailImageView.image = UIImage(named: cat.image)
                
                return cell
            }
        )
        
        return dataSource
    }
    
    @IBAction func showPicture(sender: UITableView) {
        
    }

}
