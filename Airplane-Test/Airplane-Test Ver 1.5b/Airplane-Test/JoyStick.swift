//
//  JoyStick.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/21.
//

import UIKit

class JoyStick: UIView {
    let joystickSize: CGFloat = 50
    let substractSize: CGFloat = 100
    
    var innerRadius: CGFloat = 0.0
    let joystickView = UIView()
    
    var panGesture: UIPanGestureRecognizer!

    init(x: Double, y: Double) {
        super.init(frame: CGRect(x: x,
                                 y: y,
                                 width: substractSize,
                                 height: substractSize))
        self.backgroundColor = .gray
        self.layer.cornerRadius = CGFloat(substractSize / 2)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragJoystick))
        
        joystickView.isUserInteractionEnabled = true
        joystickView.addGestureRecognizer(panGesture)
        joystickView.backgroundColor = .white
        joystickView.layer.cornerRadius = CGFloat(joystickSize / 2)
        joystickView.frame = CGRect(x:  joystickSize/2.0, y: joystickSize/2.0, width: joystickSize, height: joystickSize)
        self.addSubview(joystickView)
        
        innerRadius = (substractSize - joystickSize) * 0.5
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        joystickView.frame = CGRect(x:  joystickSize/2.0, y: joystickSize/2.0, width: joystickSize, height: joystickSize)
    }
    
    func lineLength(from pt1: CGPoint, to pt2: CGPoint) -> CGFloat {
        return hypot(pt2.x - pt1.x, pt2.y - pt1.y)
    }

    func pointOnLine(from startPt: CGPoint, to endPt: CGPoint, distance: CGFloat) -> CGPoint {
        let totalDistance = lineLength(from: startPt, to: endPt)
        let totalDelta = CGPoint(x: endPt.x - startPt.x, y: endPt.y - startPt.y)
        let pct = distance / totalDistance
        let delta = CGPoint(x: totalDelta.x * pct, y: totalDelta.y * pct)
        return CGPoint(x: startPt.x + delta.x, y: startPt.y + delta.y)
    }

    @objc func dragJoystick(_ sender: UIPanGestureRecognizer) {
        let touchLocation = sender.location(in: self)

        let outerCircleViewCenter = CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height * 0.5)

        var newCenter = touchLocation

        let distance = lineLength(from: touchLocation, to: outerCircleViewCenter)

        // if the touch would put the "joystick circle" outside the "outer circle"
        // find the point on the line from center to touch, at innerRadius distance
        if distance > innerRadius {
            newCenter = pointOnLine(from: outerCircleViewCenter, to: touchLocation, distance: innerRadius)
        }

        joystickView.center = newCenter
        if panGesture.state == .ended {
            reset()
        }
    }
}
