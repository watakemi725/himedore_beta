//
//  KYCircularProgress.swift
//  KYCircularProgress
//
//  Created by Kengo Yokoyama on 2014/10/02.
//  Copyright (c) 2014 Kengo Yokoyama. All rights reserved.
//

import Foundation
import UIKit

// MARK: - KYCircularProgress
class KYCircularProgress: UIView {
    typealias progressChangedHandler = (progress: Double, circularView: KYCircularProgress) -> ()
    private var progressChangedClosure: progressChangedHandler?
    private var progressView: KYCircularShapeView!
    private var gradientLayer: CAGradientLayer!
    private var progressGuideView: KYCircularShapeView?
    private var guideLayer: CALayer?
    
    
    var progress: Double = 0.0 {
        didSet {
            let clipProgress = max( min(oldValue, Double(1.0)), Double(0.0))
            progressView.updateProgress(clipProgress)
            
            if let progressChanged = progressChangedClosure {
                progressChanged(progress: clipProgress, circularView: self)
            }
        }
    }
    
    var startAngle: Double = 0.0 {
        didSet {
            progressView.startAngle = oldValue
            progressGuideView?.startAngle = oldValue
        }
    }
    
    var endAngle: Double = 0.0 {
        didSet {
            progressView.endAngle = oldValue
            progressGuideView?.endAngle = oldValue
        }
    }
    
    var lineWidth: Double = 8.0 {
        willSet {
            progressView.shapeLayer().lineWidth = CGFloat(newValue)
        }
    }
    
    var guideLineWidth: Double = 8.0 {
        willSet {
            progressGuideView?.shapeLayer().lineWidth = CGFloat(newValue)
        }
    }
    
    var path: UIBezierPath? {
        willSet {
            progressView.shapeLayer().path = newValue?.CGPath
            progressGuideView?.shapeLayer().path = newValue?.CGPath
        }
    }
    
    var colors: [UIColor]? {
        willSet {
            updateColors(newValue)
        }
    }
    
    var progressGuideColor: UIColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.2) {
        willSet {
            guideLayer?.backgroundColor = newValue.CGColor
        }
    }

    var showProgressGuide: Bool = false {
        willSet {
            configureProgressGuideLayer(newValue)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureProgressLayer()
        configureProgressGuideLayer(showProgressGuide)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureProgressLayer()
        configureProgressGuideLayer(showProgressGuide)
    }
    
    init(frame: CGRect, showProgressGuide: Bool) {
        super.init(frame: frame)
        configureProgressLayer()
        self.showProgressGuide = showProgressGuide
        configureProgressGuideLayer(self.showProgressGuide)
    }

    private func configureProgressLayer() {
        progressView = KYCircularShapeView(frame: self.bounds)
        progressView.shapeLayer().fillColor = UIColor.clearColor().CGColor
        progressView.shapeLayer().path = path?.CGPath
        progressView.shapeLayer().strokeColor = self.tintColor.CGColor

        gradientLayer = CAGradientLayer(layer: layer)
        gradientLayer.frame = progressView.frame
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1, 0.5);
        gradientLayer.mask = progressView.shapeLayer();
        gradientLayer.colors = colors ?? [UIColor(rgba: 0x9ACDE755).CGColor, UIColor(rgba: 0xE7A5C955).CGColor]
        
        self.layer.addSublayer(gradientLayer)
    }
    
    private func configureProgressGuideLayer(showProgressGuide: Bool) {
        if showProgressGuide && progressGuideView == nil {
            progressGuideView = KYCircularShapeView(frame: self.bounds)
            progressGuideView!.shapeLayer().fillColor = UIColor.clearColor().CGColor
            progressGuideView!.shapeLayer().path = path?.CGPath
            progressGuideView!.shapeLayer().lineWidth = CGFloat(lineWidth)
            progressGuideView!.shapeLayer().strokeColor = self.tintColor.CGColor

            guideLayer = CAGradientLayer(layer: layer)
            guideLayer!.frame = progressGuideView!.frame
            guideLayer!.mask = progressGuideView!.shapeLayer()
            guideLayer!.backgroundColor = progressGuideColor.CGColor
            guideLayer!.zPosition = -1
            
            progressGuideView!.updateProgress(1.0)
            
            self.layer.addSublayer(guideLayer)
        }
    }
    
    func progressChangedClosure(completion: progressChangedHandler) {
        progressChangedClosure = completion
    }
    
    private func updateColors(colors: [UIColor]?) -> () {    
        var convertedColors: [CGColorRef] = []
        if let inputColors = colors {
            for color in inputColors {
                convertedColors.append(color.CGColor)
            }
        } else {
            convertedColors = [UIColor(rgba: 0x9ACDE7FF).CGColor, UIColor(rgba: 0xE7A5C9FF).CGColor]
        }
        gradientLayer.colors = convertedColors
    }
}

// MARK: - KYCircularShapeView
class KYCircularShapeView: UIView {
    var startAngle = 0.0
    var endAngle = 0.0
    
    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    
    private func shapeLayer() -> CAShapeLayer {
        return self.layer as! CAShapeLayer
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateProgress(0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if startAngle == endAngle {
            endAngle = startAngle + (M_PI * 2)
        }
        shapeLayer().path = shapeLayer().path ?? layoutPath().CGPath
    }
    
    private func layoutPath() -> UIBezierPath {
        var halfWidth = CGFloat(self.frame.size.width / 2.0)
        return UIBezierPath(arcCenter: CGPointMake(halfWidth, halfWidth), radius: halfWidth - shapeLayer().lineWidth, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
    }
    
    private func updateProgress(progress: Double) {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        shapeLayer().strokeEnd = CGFloat(progress)
        CATransaction.commit()
    }
}

// MARK: - UIColor Extension
extension UIColor {
    convenience init(rgba: Int64) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        red   = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        green = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        blue  = CGFloat((rgba & 0x0000FF00) >> 8)  / 255.0
        alpha = CGFloat( rgba & 0x000000FF)        / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
