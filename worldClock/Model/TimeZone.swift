//
//  TimeZone.swift
//  worldClock
//
//  Created by Min Hu on 2023/12/15.
//

import Foundation
import UIKit
struct TimeZoneInfo{
    let timeZone: String // 時區的城市名
    let time: String // 時間
    let isToday: String // 與當地時間比，是今天、昨天還是明天
    let jetLag: String // 與當地時間的時差
}
// 使用的時區們
var citysInput = ["Asia/Taipei", "Europe/Paris", "Pacific/Auckland", "America/Los_Angeles", "Asia/Tokyo","Africa/Cairo","Pacific/Easter","America/Sao_Paulo"]

// 取得城市名：將時區中的城市取出的函數
func seperateCity(TimeZone:String) -> String {
    // 將傳入的時區字符串賦值給一個局部變量
    let continentCity = TimeZone

    // 使用 "/" 分割時區字符串，例如 "Europe/Paris" 會被分割成 ["Europe", "Paris"]
    let continentCityArray = continentCity.components(separatedBy: "/")

    // 使用 guard 語句確保分割後的數組至少有兩個元素（即包含大洲和城市）
    // 如果不符合條件（即時區字符串不包含 "/"），則直接返回原始的時區字符串
    guard continentCityArray.count > 1 else { return TimeZone }

    // 從分割後的數組中取出第二個元素（城市名），這是因為時區通常以 "大洲/城市" 的格式給出
    var city = continentCityArray[1]

    // 檢查城市名稱中是否包含下劃線 "_"
    if city.contains("_") {
        // 如果城市名稱中包含下劃線，則將其替換為空格
        // 例如 "Los_Angeles" 會被替換成 "Los Angeles"
        city = city.replacingOccurrences(of: "_", with: " ")
    }

    // 返回處理後的城市名稱
    return city
}

// 取得 city 的時間（原本的時區，包含大洲的，例如 Asia/Taipei）
func getCurrentTime(city: String) -> String {
    // 創建一個 DateFormatter 對象來格式化日期和時間
    let dateFormatter = DateFormatter()

    // 設置 DateFormatter 的時間顯示風格為短格式，這將只顯示時間而不顯示日期
    dateFormatter.timeStyle = .short

    // 設置 DateFormatter 的時區為傳入的 city 參數所對應的時區
    dateFormatter.timeZone = TimeZone(identifier: city)

    // 獲取當前日期和時間的 Date 實例
    let currentTime = Date()

    // 使用 dateFormatter 將當前時間轉換為字符串，並根據設定的時區進行格式化
    // 這將返回一個表示在指定時區的當前時間的字符串
    return dateFormatter.string(from: currentTime)
}

// 比較對比時區和當前時區時的時間是否為同一天
func isWhichDay(city: String) -> String {
    // 創建一個 DateFormatter 用於格式化日期
    let dateFormatter = DateFormatter()
    // 設定日期格式
    dateFormatter.dateFormat = "yyyy-MM-dd"

    // 設定 dateFormatter 的時區為當前時區，並獲取當前日期的字符串表示
    dateFormatter.timeZone = .current
    let dateInCurrentTimeZone = dateFormatter.string(from: Date())

    // 將 dateFormatter 的時區更改為函數參數指定的城市時區
    dateFormatter.timeZone = TimeZone(identifier: city)
    // 然後獲取該時區的當前日期的字符串表示
    let dateInComparedTimeZone = dateFormatter.string(from: Date())

    // 使用 Calendar 來處理日期
    let calendar = Calendar.current

    // 將日期字符串轉換回日期對象，這裡需要確保字符串的格式與 dateFormatter 設定的格式匹配
    guard let currentZoneDate = dateFormatter.date(from: dateInCurrentTimeZone),
          let comparedZoneDate = dateFormatter.date(from: dateInComparedTimeZone) else {
        // 如果無法進行轉換，返回錯誤信息
        return "Error in date conversion"
    }

    // 從轉換得到的日期中提取年、月、日組件
    let dateComponentCurrent = calendar.dateComponents([.year, .month, .day], from: currentZoneDate)
    let dateComponentCompared = calendar.dateComponents([.year, .month, .day], from: comparedZoneDate)

    // 計算兩個日期之間的天數差異
    let daysDiff = calendar.dateComponents([.day], from: dateComponentCurrent, to: dateComponentCompared).day!

    // 根據天數差異決定返回的字符串
    switch daysDiff {
    case 0:
        return "Today," // 如果沒有差異，表示為「今天」
    case 1:
        return "Tomorrow," // 如果差異為一天，表示為「明天」
    case -1:
        return "Yesterday," // 如果差異為負一天，表示為「昨天」
    default:
        return "Different day" // 其他情況表示為「不同的一天」
    }
}


// 計算時差
func getDaysDiff(city: String) -> String {
    // 獲取輸入城市的時區
    guard let cityTimeZone = TimeZone(identifier: city) else {
        return "Invalid city timezone"
    }

    // 獲取當前時區
    let currentTimeZone = TimeZone.current

    // 計算兩個時區相對於 GMT 的秒數差
    let timeDifference = cityTimeZone.secondsFromGMT() - currentTimeZone.secondsFromGMT()

    // 將秒數差轉換成小時
    let hoursDifference = timeDifference / 3600

    // 格式化輸出
    return String(format: "%+dHRS", hoursDifference)
}
// 調整時間的 AM PM 大小
func customLabelFount(text:String)->NSMutableAttributedString{
    // Initialization code
    let fontSizeForLastTwoCharacters: CGFloat = 24 // 最後兩個字符的字體大小
    let regularFontSize: CGFloat = 60 // 其他文字的正常字體大小
    
    // 創建一個 NSMutableAttributedString，它包含完整的文本
    let attributedString = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: regularFontSize)])
    // 計算範圍以更改最後兩個字符的字體大小
    let range = NSRange(location: text.count - 2, length: 2)
    // 更新最後兩個字符的字體大小
    attributedString.setAttributes([.font: UIFont.systemFont(ofSize: fontSizeForLastTwoCharacters)], range: range)
    
    // 將 UILabel 的 attributedText 設定為剛剛創建的 NSMutableAttributedString
    return attributedString
}
