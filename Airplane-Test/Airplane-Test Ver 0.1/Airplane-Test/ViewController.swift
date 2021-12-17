//
//  ViewController.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/2.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    let plane = Plane(frame: CGRect())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        configureController()
        configurePlane()
    }

    override var shouldAutorotate: Bool {
        return false
    }

    func configureBackground() {
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        view.backgroundColor = .black
    }
    
    func configureController() {
        let height = view.frame.height/2
        let width = view.frame.width
        
        let upButton = UIButton(frame: CGRect(x: 0, y: 0, width: height, height: height))
        upButton.setImage(UIImage(systemName: "arrowtriangle.up.circle"), for: .normal)
        upButton.setImage(UIImage(systemName: "arrowtriangle.up.circle.fill"), for: .highlighted)
        upButton.addTarget(self, action: #selector(controlPlaneUP), for: .touchDown)
        
        let downButton = UIButton(frame: CGRect(x: 0, y: height, width: height, height: height))
        downButton.setImage(UIImage(systemName: "arrowtriangle.down.circle"), for: .normal)
        downButton.setImage(UIImage(systemName: "arrowtriangle.down.circle.fill"), for: .highlighted)
        downButton.addTarget(self, action: #selector(controlPlaneDown), for: .touchUpInside)
        
        let fireButton = UIButton(frame: CGRect(x: width - height, y: height, width: height, height: height))
        fireButton.setImage(UIImage(systemName: "atom"), for: .normal)
        fireButton.addTarget(self, action: #selector(controlPlaneFire), for: .touchUpInside)
        
        view.addSubview(upButton)
        view.addSubview(downButton)
        view.addSubview(fireButton)
    }
    
    func configurePlane() {
        let height = view.frame.height/2
        view.addSubview(plane)
        plane.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerY.equalToSuperview()
            make.centerX.equalTo(view.snp.leading).offset(0.75 * height)
        }
    }
    
    @objc func controlPlaneUP() {
        if plane.frame.origin.y > 0 {
            UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
                self.plane.center.y -= self.plane.frame.height
            }, completion: nil)
        }
    }
    
    @objc func controlPlaneDown() {
        let current = plane.frame.origin.y + plane.frame.height
        let limit = view.frame.height
        if current < limit {
            UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
                self.plane.center.y += self.plane.frame.height
            }, completion: nil)
        }
    }
    
    @objc func controlPlaneFire() {
        let location_y = plane.frame.origin.y + plane.frame.height/2
        let x = plane.frame.origin.x + plane.frame.width + 10
        print(x)
        let y = plane.frame.origin.y + plane.frame.height/2
        print(y)
        
        let newTorpedo = Torpedo(frame: CGRect())
        
        view.addSubview(newTorpedo)
        newTorpedo.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height:20))
            make.centerX.equalTo(x)
            make.centerY.equalTo(y)
        }
        
        UIView.animate(withDuration: 0, delay: 0.0, options: [], animations: {
            newTorpedo.center.x += 1
        },completion: {_ in
            UIView.animate(withDuration: 1, delay: 0.5, options: [], animations: {
                newTorpedo.center.x += self.view.frame.width
            },completion: {_ in
                newTorpedo.isHidden = true
            })
        })
        
    }
    
    
}
