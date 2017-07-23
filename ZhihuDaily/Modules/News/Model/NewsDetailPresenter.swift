//
//  NewsDetailPresenter.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/6.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol NewsDetailPresenterDelegate: NSObjectProtocol {
    func getDetailData(_ newsDetail: NewsDetail?, error: Error?)
    func getExtraData(_ extraModel: NewsExtra?, error: Error?)
}

class NewsDetailPresenter: NSObject {
    
    weak var delegate: NewsDetailPresenterDelegate?
    
    func loadDetailData(_ newsId: String) {
        let url: String = "news/" + newsId
        NetworkManager.getUrl(url, params: nil) { [unowned self] (data, error) in
            if let getData = data {
                let json = JSON(getData)
                let newDetail = NewsDetail(json: json)
                self.delegate?.getDetailData(newDetail, error: nil)
            } else {
                if let getError = error {
                    print(getError)
                }
                self.delegate?.getDetailData(nil, error: error)
            }
        }
    }
    
    func loadExtraData(_ newsId: String) -> Void {
        let url: String = "story-extra/" + newsId
        NetworkManager.getUrl(url, params: nil) { [unowned self] (data, error) in
            if let getData = data {
                let json = JSON(getData)
                let extraModel = NewsExtra(json: json)
                self.delegate?.getExtraData(extraModel, error: nil)
            } else {
                if let getError = error {
                    print(getError)
                }
                self.delegate?.getExtraData(nil, error: error)
            }
        }
    }
}
