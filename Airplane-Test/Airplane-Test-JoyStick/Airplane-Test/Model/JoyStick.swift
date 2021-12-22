//
//  JoyStick.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/21.
//

import UIKit

public struct JoyStickData: CustomStringConvertible {
    var velocity = CGPoint.zero,
        angular = CGFloat(0)

    mutating func reset() {
        velocity = CGPoint.zero
        angular = 0
    }

    public var description: String {
        return "JoyStickData(velocity: \(velocity), angular: \(angular))"
    }
}

class JoyStick: UIView {
    private let joystickSize: CGFloat = 50
    private let substractSize: CGFloat = 100
    private var innerRadius: CGFloat = 0.0
    var tracking = false
    private var data = JoyStickData()

    let joystickView = UIView()

    var panGesture: UIPanGestureRecognizer!
    var velocityLoop: CADisplayLink!
    var handler: ((JoyStickData) -> Void)?

    init(x: Double, y: Double) {
        super.init(frame: CGRect(x: x,
                                 y: y,
                                 width: substractSize,
                                 height: substractSize))
        backgroundColor = .gray
        layer.cornerRadius = CGFloat(substractSize / 2)

        panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragJoystick))

        joystickView.isUserInteractionEnabled = true
        joystickView.addGestureRecognizer(panGesture)
        joystickView.backgroundColor = .white
        joystickView.layer.cornerRadius = CGFloat(joystickSize / 2)
        joystickView.frame = CGRect(x: joystickSize / 2.0, y: joystickSize / 2.0, width: joystickSize, height: joystickSize)
        addSubview(joystickView)

        innerRadius = (substractSize - joystickSize) * 0.5

        velocityLoop = CADisplayLink(target: self, selector: #selector(listen))
        velocityLoop.add(to: RunLoop.current, forMode: RunLoop.Mode(rawValue: RunLoop.Mode.common.rawValue))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reset() {
        joystickView.frame = CGRect(x: joystickSize / 2.0, y: joystickSize / 2.0, width: joystickSize, height: joystickSize)
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
        tracking = true
        let touchLocation = sender.location(in: self)

        let outerCircleViewCenter = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)

        var newCenter = touchLocation

        let distance = lineLength(from: touchLocation, to: outerCircleViewCenter)

        if distance > innerRadius {
            newCenter = pointOnLine(from: outerCircleViewCenter, to: touchLocation, distance: innerRadius)
        }

        joystickView.center = newCenter

        var dataCenter = CGPoint(x: newCenter.x - 50, y: newCenter.y - 50)
        data = JoyStickData(velocity: dataCenter, angular: -atan2(dataCenter.x, dataCenter.y))

        if panGesture.state == .ended {
            reset()
            tracking = false
        }
    }

    @objc func listen() {
        if tracking {
            handler?(data)
        }
    }
}
