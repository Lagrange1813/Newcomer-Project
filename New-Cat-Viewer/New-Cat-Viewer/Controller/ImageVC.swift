//
//  ImageViewController.swift
//  New-Cat-Viewer
//
//  Created by 张维熙 on 2021/11/14.
//

import UIKit

class ImageVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    var didSetupConstraints = false
    var imageName = "001"
    lazy var imageView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: imageName)
        return view
    }()

    func configureView(){
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        setConstraints()
    }

    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.size.height.equalTo(imageView.snp.width)
        }
    }
}
