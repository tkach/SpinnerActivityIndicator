//
//  SpinnerActivityIndicator.swift
//  SpinnerActivityIndicator
//
//  Created by Alexander Tkachenko on 11/29/17.
//  Copyright © 2017 megogo. All rights reserved.
//

import UIKit

public enum SpinnerStyle {
    case small
    case large
    case custom(size: CGSize, image: UIImage)
    
    var size: CGSize {
        let imageSize: CGSize
        switch self {
        case .small:
            imageSize = CGSize(width: 44, height: 44)
        case .large:
            imageSize = CGSize(width: 88, height: 88)
        case .custom(let size, _):
            imageSize = size
        }
        return imageSize
    }
    
    var image: UIImage? {
        if case .custom(_, let customImage) = self {
            return customImage
        }
        return nil
    }
}

@IBDesignable final public class SpinnerActivityIndicator: UIView {
    @IBInspectable public var color: UIColor = .gray {
        didSet { imageView.tintColor = color }
    }
    @IBInspectable public var isAnimating: Bool = true
    
    public var style: SpinnerStyle {
        didSet {
            imageView.image = style.image ?? imageView.image
            let imageSize = style.size
            widthConstraint?.constant = imageSize.width
            heightConstraint?.constant = imageSize.height
        }
    }
    
    private lazy var imageView: UIImageView = {
        let theBundle = Bundle(for: type(of: self))
        let theImage = UIImage(named: "spinner", in: theBundle, compatibleWith: nil)
        let defaultSpinnerImage = theImage?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: defaultSpinnerImage)
        imageView.tintColor = self.color
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var spinnerController: SpinnerController = {
        SpinnerController(with: self)
    }()
    
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    public init(activityIndicatorStyle style: SpinnerStyle) {
        self.style = style
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        style = .small
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        style = .small
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func startAnimating() {
        spinnerController.start()
        isAnimating = true
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { _ in
            self.isUserInteractionEnabled = true
        }
    }
    
    func stopAnimating() {
        spinnerController.stop()
        isAnimating = false
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.isUserInteractionEnabled = true
        }
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        isAnimating ? startAnimating() : stopAnimating()
    }
    
    override public func prepareForInterfaceBuilder() {
        isAnimating ? startAnimating() : stopAnimating()
    }
    
    private func commonInit() {
        let imageSize = style.size
        if let image = style.image { imageView.image = image }
        addSubview(imageView)
        widthConstraint = imageView.widthAnchor.constraint(equalToConstant: imageSize.width)
        heightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageSize.height)
        [widthConstraint, heightConstraint].forEach { $0?.isActive = true }
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

