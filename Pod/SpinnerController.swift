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
    private let referenceView: UIView
    private let spinnerBehavior: UIDynamicItemBehavior
    private let animator: UIDynamicAnimator
    
    init(with spinner: UIView, referenceView: UIView) {
        self.spinner = spinner
        self.referenceView = referenceView
        spinnerBehavior = UIDynamicItemBehavior(items: [spinner])
        animator = UIDynamicAnimator(referenceView: self.referenceView)
        setup()
    }
    
    private func setup() {
        let panRecognizer = UIPanGestureRecognizer()
        panRecognizer.addTarget(self, action: #selector(handlePan(gesture:)))
        referenceView.addGestureRecognizer(panRecognizer)
        
        let center = referenceView.convert(spinner.center, to: referenceView)
        let centerAttachment = UIAttachmentBehavior(item: spinner, attachedToAnchor: center)
        animator.addBehavior(centerAttachment)
    }
    
    func start() {
        if (!animator.behaviors.contains(spinnerBehavior)) {
            animator.addBehavior(spinnerBehavior)
        }
        let velocity = spinnerBehavior.angularVelocity(for: spinner)
        let newVelocity = 5 - velocity
        spinnerBehavior.addAngularVelocity(newVelocity, for: spinner)
    }
    
    func stop() {
        animator.removeBehavior(spinnerBehavior)
    }
    
    var startTouchCenter: CGPoint!
    var lastTime: CFAbsoluteTime!
    var attachment: UIAttachmentBehavior!
    var lastAngle: CGFloat!
    var angularVelocity: CGFloat!
    
    @objc func handlePan(gesture: UIGestureRecognizer) {
        guard animator.behaviors.contains(spinnerBehavior) else { return }
        
        func angle(of view: UIView) -> CGFloat {
            return atan2(view.transform.b, view.transform.a)
        }
        if (gesture.state == .began) {
            startTouchCenter = spinner.center

            // calculate the center offset and anchor point
            let pointWithinAnimatedView = gesture.location(in: spinner)
            let offset = UIOffsetMake((CGFloat) (pointWithinAnimatedView.x - spinner.bounds.size.width / 2.0),
                                           (CGFloat) (pointWithinAnimatedView.y - spinner.bounds.size.height / 2.0))
            let anchor = gesture.location(in: referenceView)
            attachment = UIAttachmentBehavior(item: spinner, offsetFromCenter: offset, attachedToAnchor: anchor)
        
            lastTime = CFAbsoluteTimeGetCurrent()
            lastAngle = angle(of: spinner)
            attachment?.action = {
                [unowned self] in
                let timeInterval = CGFloat(CFAbsoluteTimeGetCurrent() - self.lastTime)
                let angularDistance = angle(of: self.spinner) - self.lastAngle
                self.angularVelocity = angularDistance / timeInterval
            }
            animator.addBehavior(attachment)
        } else if (gesture.state == .changed) {
            let anchor = gesture.location(in: referenceView)
            attachment.anchorPoint = anchor
        } else if (gesture.state == .ended || gesture.state == .cancelled) {
            animator.removeBehavior(attachment)
            spinnerBehavior.addAngularVelocity(angularVelocity, for: spinner)
        }
    }

}
