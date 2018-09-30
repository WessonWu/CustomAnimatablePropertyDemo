//
//  ProgressView.swift
//  CustomAnimatableViewProperty
//
//  Created by wuweixin on 2018/9/30.
//  Copyright © 2018 wuweixin. All rights reserved.
//

import UIKit

final class ProgressLayer: CALayer {
    @NSManaged var progress: CGFloat
    
    override init() {
        super.init()
    }
    override init(layer: Any) {
        super.init(layer: layer)
        if let presentationLayer = layer as? ProgressLayer {
            progress = presentationLayer.progress
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "progress" { return true }
        return super.needsDisplay(forKey: key)
    }
    override func action(forKey event: String) -> CAAction? {
        if event == "progress" {
            if let animation = super.action(forKey: "backgroundColor") as? CABasicAnimation {
                animation.keyPath = event
                if let pLayer = presentation() {
                    animation.fromValue = pLayer.progress
                }
                animation.isRemovedOnCompletion = true
                animation.fillMode = .forwards
                animation.toValue = nil
                return animation
            }
            setNeedsDisplay()
            return nil
        }
        return super.action(forKey: event)
    }
    
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        var frame = self.bounds
        frame.size.width *= progress
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.fill(frame)
    }
}

final class ProgressView: UIView {
    override class var layerClass: Swift.AnyClass { return ProgressLayer.self }
    
    var progressLayer: ProgressLayer { return layer as! ProgressLayer }
    
    @objc dynamic var progress: CGFloat {
        get { return progressLayer.progress }
        set { progressLayer.progress = min(1, max(0, newValue)) }
    }
}
