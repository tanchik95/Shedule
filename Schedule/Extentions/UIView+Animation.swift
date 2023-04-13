//
//  UIView+Animation.swift
//  Schedule
//
//  Created by Tatyana Anikina on 26.12.2020.
//

import UIKit

extension UIView {

    func animateWithShake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [-8.0, 8.0, -8.0, 8.0, -4.0, 4.0, -2.0, 2.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
