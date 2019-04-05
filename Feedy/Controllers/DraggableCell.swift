//
//  DraggableCell.swift
//  Feedy
//
//  Created by jack Maarek on 02/04/2019.
//  Copyright © 2019 jack Maarek. All rights reserved.
//

import UIKit

class knDraggableCell: UICollectionViewCell {
    
    private struct EffectKitSetting {
        
        static let ACTION_MARGIN: Float = 90      //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
        static let SCALE_STRENGTH: Float = 4       //%%% how quickly the card shrinks. Higher = slower shrinking
        static let SCALE_MAX:Float = 0.93          //%%% upper bar for how much the card shrinks. Higher = shrinks less
        static let ROTATION_MAX: Float = 1         //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
        static let ROTATION_STRENGTH: Float = 320  //%%% strength of rotation. Higher = weaker rotation
        static let ROTATION_ANGLE: Float = 3.14/8  //%%% Higher = stronger rotation angle
    }
    
    var delegate: knDraggableViewDelegate!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var originPoint: CGPoint!
    private var xFromCenter: Float = 0
    private var yFromCenter: Float = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(beingDragged(_:)))
        addGestureRecognizer(panGestureRecognizer)
    }
    func setupView() {}

    @objc func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        xFromCenter = Float(gestureRecognizer.translation(in: self).x)
        yFromCenter = Float(gestureRecognizer.translation(in: self).y)
        
        switch gestureRecognizer.state {
            
        case UIGestureRecognizer.State.began:
            self.originPoint = self.center
            
        case UIGestureRecognizer.State.changed:
            self.transform = swipingEffectTransform()
            
        case UIGestureRecognizer.State.ended:
            afterSwipeAction()
            
        case UIGestureRecognizer.State.possible, .cancelled, .failed:
            break
        }
    }
    
    private func swipingEffectTransform() -> CGAffineTransform {
        let rotationStrength: Float = min(xFromCenter / EffectKitSetting.ROTATION_STRENGTH, EffectKitSetting.ROTATION_MAX)
        let rotationAngle = EffectKitSetting.ROTATION_ANGLE * rotationStrength
        let scale = max(1 - fabsf(rotationStrength) / EffectKitSetting.SCALE_STRENGTH, EffectKitSetting.SCALE_MAX)
        center = CGPoint(x: originPoint.x + CGFloat(xFromCenter), y: originPoint.y + CGFloat(yFromCenter))
        let transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        return transform.scaledBy(x: CGFloat(scale), y: CGFloat(scale))
    }
    
    private func afterSwipeAction() {
        let floatXFromCenter = Float(xFromCenter)
        if floatXFromCenter > EffectKitSetting.ACTION_MARGIN {
            rightAction()
        } else if floatXFromCenter < -EffectKitSetting.ACTION_MARGIN {
            
            leftAction()
        } else {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.center = self.originPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
            })
        }
    }
    
    private func rightAction() {
        let finishPoint: CGPoint = CGPoint(x: 500, y: 2 * CGFloat(yFromCenter) + self.originPoint.y)
        swipeAction(finishPoint: finishPoint)
        delegate?.cardSwipedRight(self)
    }
    
    private func leftAction() {
        let finishPoint: CGPoint = CGPoint(x: -500, y: 2 * CGFloat(yFromCenter) + self.originPoint.y)
        swipeAction(finishPoint: finishPoint)
        delegate?.cardSwipedLeft(self)
    }
    
    private func swipeAction(finishPoint: CGPoint) {
        UIView.animate(withDuration: 0.3, animations: {
            self.center = self.originPoint
            self.transform = CGAffineTransform(rotationAngle: 0)
        })
        
    }
}

protocol knDraggableViewDelegate {
    func cardSwipedLeft(_ card: UIView) -> Void
    func cardSwipedRight(_ card: UIView) -> Void
}
