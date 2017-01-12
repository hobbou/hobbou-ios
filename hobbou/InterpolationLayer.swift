//
//  InterpolationLayer.swift
//  hobbou
//
//  Created by Hans Yonathan on 11/1/2017.
//  Copyright © 2017 Hans Yonathan. All rights reserved.
//

import UIKit

class InterpolationLayer: CALayer {
    
    @NSManaged var translationValue: CGFloat
    
    var interpolationDuration: CFTimeInterval = 0.5
    
    var interpolationHandler: ((CGFloat) -> ())?
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "translationValue" {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
    
    override func display() {
        if let presentationTranslationValue = presentation()?.value(forKey: "translationValue") as? CGFloat {
            interpolationHandler?(presentationTranslationValue)
            if presentationTranslationValue == 1 {
                removeFromSuperlayer()
            }
        }
    }
    
    override func action(forKey event: String) -> CAAction? {
        if event == "translationValue" {
            let animation = CABasicAnimation(keyPath: event)
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animation.fromValue = 0
            animation.toValue = presentation()?.value(forKey: "translationValue")
            animation.duration = interpolationDuration
            return animation
        }
        return super.action(forKey: event)
    }
    
}
