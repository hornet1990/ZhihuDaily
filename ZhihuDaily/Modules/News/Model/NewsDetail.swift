//
//  NewsDetail.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/6.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsDetail: NSObject {
    var body: String
    var imageSource: String
    var title: String
    var shareUrl: String
    var image: String
    var gaPrefix: String
    var newsId: String
    var css: [String]?
    
    init(json: JSON) {
        body = json["body"].stringValue
        imageSource = json["image_source"].stringValue
        title = json["title"].stringValue
        shareUrl = json["share_url"].stringValue
        image = json["image"].stringValue
        gaPrefix = json["ga_prefix"].stringValue
        newsId = json["id"].stringValue
        let cssArray = json["css"].array
        if let array = cssArray {
            css = [String]()
            for item in array {
                let cssStr = item.stringValue
                css?.append(cssStr)
            }
        }
    }
}
