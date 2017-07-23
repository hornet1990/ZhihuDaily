//
//  DetailTopView.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/6.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit
import Kingfisher

class DetailTopView: UIView {

    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var imageSourceLabel: UILabel!
    @IBOutlet weak var newsButton: UIButton!
    
    var detailModel: NewsDetail! {
        willSet {
            self.detailModel = newValue
        }
        didSet {
            imageSourceLabel.isHidden = false
            imageSourceLabel.text = "图片：" + detailModel.imageSource
            newsTitleLabel.text = detailModel.title
            let url = URL(string: detailModel.image)
            newsImageView.kf.setImage(with: url, placeholder: Image(named: "ico_placeHolder"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    var story: Stories! {
        willSet {
            self.story = newValue
        }
        didSet {
            imageSourceLabel.isHidden = true
            newsTitleLabel.text = story.storyTitle
            if let imgStr = story.imageStr {
                let url = URL(string: imgStr)
                newsImageView.kf.setImage(with: url, placeholder: Image(named: "ico_placeHolder"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
