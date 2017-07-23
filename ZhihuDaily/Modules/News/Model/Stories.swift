//
//  NewsToadyModel.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit
import SwiftyJSON

class Stories: NSObject {
    var imageArray: [String]?
    var imageStr: String?
    var storyTitle: String
    var storyId: String
    var multiPic: Bool?
    var gaPrefix: String
    
    public init(json: JSON) {
        storyTitle = json["title"].stringValue
        storyId = json["id"].stringValue
        imageStr = json["image"].string
        gaPrefix = json["ga_prefix"].stringValue
        multiPic = json["multipic"].bool
        let images = json["images"].array
        if let array = images {
            imageArray = [String]()
            for image in array {
                imageArray?.append(image.stringValue)
            }
        }
    }
}
