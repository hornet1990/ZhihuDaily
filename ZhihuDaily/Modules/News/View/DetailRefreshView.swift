//
//  DetailRefreshView.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/12.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit

enum DetailRefreshType {
    case header
    case footer
}

class DetailRefreshView: UIView {

    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var maskImageView: UIImageView!
    //显示箭头为12.5，不显示箭头为0
    @IBOutlet weak var tipCenterX: NSLayoutConstraint!
    
    var refreshType: DetailRefreshType! {
        willSet {
            self.refreshType = newValue
        }
        didSet {
            if refreshType == .header {
                maskImageView.isHidden = false
                tipLabel.textColor = .white
                arrowImageView.image = UIImage(named: "ico_refreshLast")
            } else {
                maskImageView.isHidden = true
                tipLabel.textColor = .lightGray
                arrowImageView.image = UIImage(named: "ico_refreshNext")
            }
        }
    }
    
    var refreshModel: DetailRefreshModel! {
        didSet {
            if refreshType == .header {
                if let last = refreshModel.hasLast {
                    if last {
                        arrowImageView.isHidden = false
                        tipCenterX.constant = 12.5
                    } else {
                        arrowImageView.isHidden = true
                        tipCenterX.constant = 0
                    }
                } else {
                    arrowImageView.isHidden = true
                    tipCenterX.constant = 0
                }
                tipLabel.text = refreshModel.lastTipStr
            } else {
                if let next = refreshModel.hasNext {
                    if next {
                        arrowImageView.isHidden = false
                        tipCenterX.constant = 12.5
                    } else {
                        arrowImageView.isHidden = true
                        tipCenterX.constant = 0
                    }
                } else {
                    arrowImageView.isHidden = true
                    tipCenterX.constant = 0
                }
                tipLabel.text = refreshModel.nextTipStr
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }

}
