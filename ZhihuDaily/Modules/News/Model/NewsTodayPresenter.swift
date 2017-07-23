//
//  NewsTodayPresenter.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol NewsTodayPresenterDelegate: NSObjectProtocol {
    func newTodayPresenter(_ error: Error?, json: Any?) -> Void
    func newBeforePresenter(_ error: Error?, json: Any?) -> Void
}

class NewsTodayPresenter: NSObject {
    
    var dateStr: String?
    weak var delegate: NewsTodayPresenterDelegate?
    lazy var listArray: [[Stories]] = {
        var array = [[Stories]]()
        return array
    }()
    
    lazy var topArray: [Stories] = {
        var array = [Stories]()
        return array
    }()
    
    lazy var headerArray: [String] = {
        var array = [String]()
        return array
    }()
    
    func loadListData() {
        NetworkManager.getUrl("news/latest", params: nil) { [unowned self] (data, error) in
            if let getData = data {
                self.listArray.removeAll()
                self.topArray.removeAll()
                self.headerArray.removeAll()
                let json = JSON(getData)
                let dateStr = json["date"].string
                let weekStr = getDateAndWeekWithStr(dateStr)
                self.dateStr = dateStr
                self.headerArray.append(weekStr)
                let storyArray = json["stories"].arrayValue
                var newArray = [Stories]()
                for story in storyArray {
                    let newsModel = Stories(json: story)
                    newArray.append(newsModel)
                }
                self.listArray.append(newArray)
                let topStoryArray = json["top_stories"].arrayValue
                for story in topStoryArray {
                    let topModel = Stories(json: story)
                    self.topArray.append(topModel)
                }
            } else {
                if let getError = error {
                    print(getError)
                }
            }
            self.delegate?.newTodayPresenter(error, json: data)
        }
    }
    
    func loadBeforeData() -> Void {
        var beforeDateStr = getDateStrWithDate(Date(), formatStr: "yyyyMMdd")
        if let dateString = dateStr {
            beforeDateStr = dateString
        }
        NetworkManager.getUrl("news/before/" + beforeDateStr, params: nil) { [unowned self] (data, error) in
            if let getData = data {
                let json = JSON(getData)
                let dateStr = json["date"].string
                let weekStr = getDateAndWeekWithStr(dateStr)
                self.dateStr = dateStr
                self.headerArray.append(weekStr)
                let storyArray = json["stories"].arrayValue
                var newArray = [Stories]()
                for story in storyArray {
                    let newsModel = Stories(json: story)
                    newArray.append(newsModel)
                }
                self.listArray.append(newArray)
            } else {
                if let getError = error {
                    print(getError)
                }
            }
            self.delegate?.newBeforePresenter(error, json: data)
        }
    }
}
