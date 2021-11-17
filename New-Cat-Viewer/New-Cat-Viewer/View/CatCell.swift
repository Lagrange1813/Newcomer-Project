//
//  CatTableViewCell.swift
//  New-Cat-Viewer
//
//  Created by 张维熙 on 2021/11/16.
//

import UIKit
import SnapKit

class CatCell: UITableViewCell {
    
    var imgView = UIImageView()
    var nameLabel = UILabel()
    var stepLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imgView)
        addSubview(nameLabel)
        addSubview(stepLabel)
        
        configureImgView()
        configureNameLabel()
        configureStepLabel()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cat: Cat) {
        imgView.image = UIImage(named: cat.image)
        nameLabel.text = cat.name
        stepLabel.text = cat.step
    }
    
    
    func configureImgView() {
        imgView.layer.cornerRadius = 15
        imgView.clipsToBounds = true
    }
    
    
    func configureNameLabel() {
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    func configureStepLabel() {
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    func setConstraints() {

        imgView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 120, height: 120))
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.top)
            make.leading.equalTo(imgView.snp.trailing).offset(20)
        }

        stepLabel.snp.makeConstraints { make in
            make.leading.equalTo(imgView.snp.trailing).offset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
}
