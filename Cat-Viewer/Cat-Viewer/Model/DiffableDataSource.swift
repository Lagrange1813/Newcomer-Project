//
//  DiffableDataSource.swift
//  Cat-Viewer
//
//  Created by Lagrange1813 on 2021/11/3.
//

import UIKit
enum Section {
    case all
}

class DiffableDataSource: UITableViewDiffableDataSource<Section,Cat> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    override func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
               if let restaurant = self.itemIdentifier(for: indexPath) {
                   var snapshot = self.snapshot()
                   snapshot.deleteItems([restaurant])
                   self.apply(snapshot, animatingDifferences: true)
               }
        }
    }
    
}
