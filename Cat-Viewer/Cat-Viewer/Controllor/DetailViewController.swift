//
//  DetailViewController.swift
//  Cat-Viewer
//
//  Created by Lagrange1813 on 2021/11/4.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        catImageView.image = UIImage(named: catImageName)
    }
    
    @IBOutlet var catImageView: UIImageView!
    var catImageName = ""

}
