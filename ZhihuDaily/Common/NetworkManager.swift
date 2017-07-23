//
//  NetworkManager.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/5.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import UIKit
import Alamofire

typealias NetWorkCallBack = ((_ data: Any?, _ error: Error?) -> ())

class NetworkManager: NSObject {
    static public func getUrl(_ url: String, params: [String: AnyObject]?, callBack: @escaping NetWorkCallBack) -> Void {
        let requestUrl = BaseUrl + url
        Alamofire.request(requestUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                callBack(response.result.value, nil)
            } else {
                callBack(nil, response.result.error)
            }
        }
    }
}
