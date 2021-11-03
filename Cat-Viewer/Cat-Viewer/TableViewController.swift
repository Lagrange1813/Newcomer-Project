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
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(catNames, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    var catNames = ["这是第1张猫猫", "这是第2张猫猫", "这是第3张猫猫", "这是第4张猫猫", "这是第5张猫猫", "这是第6张猫猫", "这是第7张猫猫"]
    var catStepNames = ["这是第1张猫猫", "这是第2张猫猫", "这是第3张猫猫", "这是第4张猫猫", "这是第5张猫猫", "这是第6张猫猫", "这是第7张猫猫"]
    var catImages = ["001", "002", "003", "004", "005", "006", "007"]
    
    enum Section {
        case all
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String >{
        let cellIdentifier = "datacell"
        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, catName in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
                
                cell.nameLabel.text = catName
                cell.stepLabel.text = catName
                cell.thumbnailImageView.image = UIImage(named: self.catImages[indexPath.row])
                
                return cell
            }
        )
        
        return dataSource
    }
    
    @IBAction func showPicture(sender: UITableView) {
        
    }

}
