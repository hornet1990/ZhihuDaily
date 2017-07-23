//
//  NewsExtra.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/12.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsExtra: NSObject {
    var longComments: Int?
    var popularity: Int?
    var shortComments: Int?
    var comments: Int?
    
    init(json: JSON) {
        longComments = json["long_comments"].int
        popularity = json["popularity"].int
        shortComments = json["short_comments"].int
        comments = json["comments"].int
    }
}
