//
//  CatDataSource.swift
//  New-Cat-Viewer
//
//  Created by 张维熙 on 2021/11/17.
//

import UIKit
enum Section {
    case all
}

class DiffableDataSource: UITableViewDiffableDataSource<Section,Cat> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
    
}
