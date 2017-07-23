//
//  LeftDrawerTableViewCell.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/5.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit

class LeftDrawerTableViewCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeLabelLeading: NSLayoutConstraint!
    //有图50 无图15
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
