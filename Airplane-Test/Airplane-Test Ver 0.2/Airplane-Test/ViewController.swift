//
//  ViewController.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/2.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    var collision: UICollisionBehavior!
    var animtor: UIDynamicAnimator!
    var push: UIPushBehavior!
    
    let plane = UIImageView()
    var time = Date()
    
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
        let plane_width = 50.0
        let plane_height = 50.0
        let x = view.frame.size.height * 0.75 * 0.5
        let y = view.frame.size.height/2.0 - plane_height/2.0
        
        plane.image = UIImage(named: "shuttle")
        plane.frame = CGRect(x: x, y: y, width: plane_width, height: plane_height)
        
        view.addSubview(plane)
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
        var current = Date()
        print(current.timeIntervalSince1970)
        if current.timeIntervalSince1970 - time.timeIntervalSince1970 > 0.2 {
            time = current
            animtor = UIDynamicAnimator(referenceView: view)
            
            let torpedo_width = 20.0
            let torpedo_height = 20.0
            let x = plane.frame.origin.x + plane.frame.width + 10.0
            let y = plane.frame.origin.y + plane.frame.height/2.0 - torpedo_height/2.0
            
            let newTorpedo = UIImageView()
            newTorpedo.image = UIImage(named: "torpedo")
            newTorpedo.frame = CGRect(x: x, y: y, width: torpedo_width, height: torpedo_height)
            
            view.addSubview(newTorpedo)
            
            push = UIPushBehavior(items: [newTorpedo], mode: .instantaneous)
    //        push.pushDirection = CGVector(dx: 0, dy: 1)
            push.setAngle(0, magnitude: 1.0)
            animtor.addBehavior(push)
        }
    }
}
