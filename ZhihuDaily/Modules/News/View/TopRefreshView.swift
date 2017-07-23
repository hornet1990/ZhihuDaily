//
//  TopRefreshView.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/11.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit

class TopRefreshView: UIView {

    var circleLayer: CAShapeLayer?
    var progressLayer: CAShapeLayer?
    var indicator: UIActivityIndicatorView?
    
    var scrollOffSetY: CGFloat! {
        didSet {
            if scrollOffSetY < 0 && scrollOffSetY >= -64 {
                let offSetY = -scrollOffSetY
                let width = self.frame.size.width
                let startAngle = -(CGFloat)(M_PI_2)
                let endAngle = (CGFloat)(M_PI) * 2
                var percent = offSetY / 60.0
                if percent > 1.0 {
                    percent = 1.0
                }
                let progressPath = UIBezierPath(arcCenter: CGPoint(x: width / 2.0, y: width / 2.0), radius: width / 2.0 - 2, startAngle: startAngle, endAngle: startAngle + endAngle * percent, clockwise: true)
                progressPath.lineWidth = 1.0
                progressLayer?.path = progressPath.cgPath
            } else if scrollOffSetY == 0 {
                self.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createSubViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }
    
    func createSubViews() -> Void {
        circleLayer = CAShapeLayer()
        progressLayer = CAShapeLayer()
        let width = self.frame.size.width
        
        let startAngle = -(CGFloat)(M_PI_2)
        let endAngle = (CGFloat)(M_PI) * 2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: width / 2.0, y: width / 2.0), radius: width / 2.0 - 2, startAngle: startAngle, endAngle: startAngle + endAngle, clockwise: true)
        circlePath.lineWidth = 1.0
        circleLayer?.strokeColor = UIColor.black.withAlphaComponent(0.4).cgColor
        circleLayer?.fillColor = UIColor.clear.cgColor
        circleLayer?.path = circlePath.cgPath
        self.layer.addSublayer(circleLayer!)
        
        let progressPath = UIBezierPath(arcCenter: CGPoint(x: width / 2.0, y: width / 2.0), radius: width / 2.0 - 2, startAngle: 0, endAngle: 0, clockwise: true)
        progressPath.lineWidth = 1.0
        progressLayer?.path = progressPath.cgPath
        progressLayer?.strokeColor = UIColor.white.cgColor
        progressLayer?.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(progressLayer!)
        
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator?.frame = CGRect(x: 0, y: 0, width: width, height: width)
        indicator?.isHidden = true
        self.addSubview(indicator!)
    }
    
    func showIndicator() -> Void {
        indicator?.isHidden = false
        indicator?.startAnimating()
        progressLayer?.isHidden = true
        circleLayer?.isHidden = true
    }
    
    func hideIndicator() -> Void {
        indicator?.stopAnimating()
        indicator?.isHidden = true
        isHidden = true
        progressLayer?.isHidden = false
        circleLayer?.isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }

}
