//
//  SpinnerController.swift
//  SpinnerActivityIndicator
//
//  Created by Alexander Tkachenko on 8/22/17.
//  Copyright © 2017 megogo. All rights reserved.
//

import UIKit

final class SpinnerController {
    private let spinner: UIView
    private var behavior: UIDynamicItemBehavior
    private let panRecognizer: UIGestureRecognizer
    private lazy var animator: UIDynamicAnimator = {
        guard let reference = self.spinner.superview else {
            fatalError("SpinnerController spinner's superview is nil." +
                "please add spinner to view hierarchy before creating SpinnerController")
        }
        return UIDynamicAnimator(referenceView: reference)
        }()
    
    
    init(with spinner: UIView) {
        self.spinner = spinner
        behavior = UIDynamicItemBehavior(items: [spinner])
        panRecognizer = UIPanGestureRecognizer()
        setup()
    }
    
    private func setup() {
        behavior.angularResistance = 0
        behavior.resistance = 0
        behavior.friction = 0
        panRecognizer.addTarget(self, action: #selector(handlePan(gesture:)))
        spinner.addGestureRecognizer(panRecognizer)
        behavior.addAngularVelocity(5, for: spinner)
        spinner.isUserInteractionEnabled = true
        
        let centerAttachment = UIAttachmentBehavior(item: spinner, attachedToAnchor: spinner.center)
//        centerAttachment.action = {
//            [weak self] in
//            self?.fixSpinnerResistance()
//        }
        animator.addBehavior(centerAttachment)
    }
    
    func start() {
        if (!animator.behaviors.contains(behavior)) {
            animator.addBehavior(behavior)
            behavior.friction = 0
        }
        else {
            let velocity = behavior.angularVelocity(for: spinner)
            let newVelocity = 5 - velocity
            behavior.addAngularVelocity(newVelocity, for: spinner)
        }
    }
    
    func stop() {
//        let velocity = behavior.angularVelocity(for: spinner)
//        let newVelocity = 5 - velocity
//        behavior.friction = 100
//        behavior.addAngularVelocity(newVelocity, for: spinner)
//        animator.removeBehavior(behavior)
    }
    
    var startTouchCenter: CGPoint!
    var lastTime: CFAbsoluteTime!
    var attachment: UIAttachmentBehavior!
    var lastAngle: CGFloat!
    var angularVelocity: CGFloat!
    
    @objc func handlePan(gesture: UIGestureRecognizer) {
        guard animator.behaviors.contains(behavior) else { return }
        
        func angle(of view: UIView) -> CGFloat {
            return atan2(view.transform.b, view.transform.a)
        }

        if (gesture.state == .began) {
            startTouchCenter = spinner.center

            // calculate the center offset and anchor point
            let pointWithinAnimatedView = gesture.location(in: spinner)
            let offset = UIOffsetMake((CGFloat) (pointWithinAnimatedView.x - spinner.bounds.size.width / 2.0),
                                           (CGFloat) (pointWithinAnimatedView.y - spinner.bounds.size.height / 2.0))
            let anchor = gesture.location(in: spinner.superview)
            attachment = UIAttachmentBehavior(item: spinner, offsetFromCenter: offset, attachedToAnchor: anchor)
        
            lastTime = CFAbsoluteTimeGetCurrent()
            lastAngle = angle(of: spinner)
            attachment?.action = {
                [unowned self] in
                let time = CFAbsoluteTimeGetCurrent()
                let newAngle = angle(of: self.spinner)
                self.angularVelocity = (newAngle - self.lastAngle) / (CGFloat(time) - CGFloat(self.lastTime))
            }
            animator.addBehavior(attachment)
        } else if (gesture.state == .changed) {
            let anchor = gesture.location(in: spinner.superview!)
            attachment.anchorPoint = anchor
        } else if (gesture.state == .ended || gesture.state == .cancelled) {
            animator.removeBehavior(attachment)
            behavior.addAngularVelocity(angularVelocity, for: spinner)
        }
    }
    
//    private func fixSpinnerResistance() {
//        let velocity = behavior.angularVelocity(for: spinner)
//        if (-5...5 ~= velocity) {
//            behavior.angularResistance = 0
//            let targetVelocity: CGFloat = velocity > 0 ? 5.1 : -5.1
//            let newVelocity = targetVelocity - velocity
//            behavior.addAngularVelocity(newVelocity, for: spinner)
//        }
//        else {
//            behavior.angularResistance = 1
//        }
//    }
    
}
