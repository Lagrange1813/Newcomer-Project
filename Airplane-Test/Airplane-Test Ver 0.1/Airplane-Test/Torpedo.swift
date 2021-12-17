//
//  Torpedo.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/2.
//

import UIKit

class Torpedo: UIImageView {

    override init(frame: CGRect) {
        super.init(image: UIImage(named: "torpedo"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
