//
//  ImageViewController.swift
//  New-Cat-Viewer
//
//  Created by 张维熙 on 2021/11/14.
//

import UIKit

class ImageViewController: UIViewController {
    var didSetupConstraints = false

    var imageName = "001"
    lazy var imageView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: imageName)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        view.addSubview(imageView)

        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        if !didSetupConstraints {
            imageView.snp.makeConstraints { make in
                make.center.equalTo(view)
                make.size.equalTo(CGSize(width: 400, height: 400))
            }

            didSetupConstraints = true
        }

        super.updateViewConstraints()
    }
}
