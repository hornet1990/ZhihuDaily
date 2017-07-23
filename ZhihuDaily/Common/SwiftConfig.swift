//
//  SwiftConfig.swift
//  ZhihuDaily
//
//  Created by Andrew on 2017/7/4.
//  Copyright © 2017年 Andrew. All rights reserved.
//

import Foundation
import UIKit

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
    return UIColor.init(colorLiteralRed: ((Float)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((Float)((rgbValue & 0xFF00) >> 8))/255.0, blue: ((Float)(rgbValue & 0xFF))/255.0, alpha: 1.0)
}

func getDateStrWithDate(_ date: Date, formatStr: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = formatStr
    return formatter.string(from: date)
}

func getDateWithDateStr(_ dateStr: String, formatStr: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = formatStr
    return formatter.date(from: dateStr)
}

func getWeekDayWithDate(_ date: Date) -> String {
    let weekArray = ["", "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
    var calendar = Calendar(identifier: .gregorian)
    let timeZone = TimeZone(identifier: "Asia/Shanghai")
    calendar.timeZone = timeZone!
    let weekComponent = calendar.component(.weekday, from: date)
    return weekArray[weekComponent]
}

func getDateAndWeekWithStr(_ dateStr: String?) -> String {
    if let dateString = dateStr {
        let date = getDateWithDateStr(dateString, formatStr: "yyyyMMdd")
        if let getDate = date {
            let monthDay = getDateStrWithDate(getDate, formatStr: "MM月dd日")
            let sepArray = monthDay.components(separatedBy: "月")
            let firstStr = sepArray[0]
            var secondStr = sepArray[1]
            if secondStr.hasPrefix("0") {
                let index = secondStr.index(secondStr.startIndex, offsetBy: 1)
                secondStr = secondStr.substring(from: index)
            }
            let weekStr = getWeekDayWithDate(getDate)
            return firstStr + "月" + secondStr + " " + weekStr
        }
    }
    return ""
}

let BaseUrl: String = "https://news-at.zhihu.com/api/4/"
