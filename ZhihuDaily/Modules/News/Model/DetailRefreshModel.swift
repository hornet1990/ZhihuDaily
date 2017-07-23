//
//  DetailRefreshModel.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/12.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit

class DetailRefreshModel: NSObject {
    var hasLast: Bool?
    var hasNext: Bool?
    var lastNewsId: String?
    var nextNewsId: String?
    var lastTipStr: String?
    var nextTipStr: String?
    
    init(newsId: String, newsIdArray: [String]?) {
        super.init()
        if let array = newsIdArray {
            if array.contains(newsId) {
                let index = array.index(of: newsId)
                if index == 0 {
                    hasLast = false
                    lastNewsId = ""
                    lastTipStr = "已经是第一篇"
                    if array.count > 1 {
                        hasNext = true
                        nextNewsId = array[1]
                        nextTipStr = "载入下一篇"
                    } else {
                        hasNext = false
                        nextNewsId = ""
                        nextTipStr = "已经是最后一篇"
                    }
                } else if index == array.count - 1 {
                    hasNext = false
                    nextNewsId = ""
                    nextTipStr = "已经是最后一篇"
                    
                    hasLast = true
                    lastNewsId = array[array.count - 2]
                    lastTipStr = "载入上一篇"
                } else {
                    if let currentIndex = index {
                        hasNext = true
                        nextNewsId = array[currentIndex + 1]
                        nextTipStr = "载入下一篇"
                        
                        hasLast = true
                        lastNewsId = array[currentIndex - 1]
                        lastTipStr = "载入上一篇"
                    }
                }
            }
        }
    }
}
