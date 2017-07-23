//
//  NewsTodayTableViewCell.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTodayTableViewCell: UITableViewCell {

    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var multiImageView: UIImageView!
    
    var stories: Stories? {
        willSet {
            self.stories = newValue
        }
        didSet {
            if let model = stories {
                newsTitleLabel.text = model.storyTitle
                if let imageArray = model.imageArray {
                    let imgStr = imageArray[0]
                    let url = URL(string: imgStr)
                    newsImageView.kf.setImage(with: url, placeholder: Image(named: "ico_placeHolder"), options: nil, progressBlock: nil, completionHandler: nil)
                }
                multiImageView.isHidden = true
                if let showMulti = model.multiPic {
                    if showMulti {
                        multiImageView.isHidden = false
                    } else {
                        multiImageView.isHidden = true
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
