/*********************************************************************************
* 版权所有,2020,LiWei.
* Copyright(C),2020,LiWei Tech., LTD.All rights reserved.
* project:tony 助手
* Author:
* Date:2020/06/09
* QQ/Tel/Mail:
* Description:
* Others:
* Modifier:
* Reason:
**********************************************************************************/

import UIKit

extension Date {
    
    /// 获取日期string
    /// - Returns: 日期格式化
    /// - 如果是当天 则显示今天 否则显示具体日期
    func fetchImageDateFormat()-> String {
        let today = Date()
        let flag = Calendar.current.isDate(today, inSameDayAs: self)
        guard !flag else {
            return "今天"
        }
        return fetchFormatTime("yyyy年MM月dd日")
    }
    
    /// 获取日期string
    /// - Returns: 20200608
    func fetchDayFormat()-> String{
        return fetchFormatTime("yyyyMMdd")
    }


    /// 获取当前时区下的格式化时间
    /// - Returns: 2020-06-08 17:56:34
    func fetchCurrentFormatTime() -> String {
        return fetchFormatTime("yyyy-MM-dd HH:mm:ss")
    }
    
    /// 获取格式化日期
    /// - Parameter format: 格式化内容
    /// - Returns: 字符串
    func fetchFormatTime(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        return formatter.string(from: self)
    }
    
    /// 获取当月的第一天
    /// - Returns: 日期
    func fetchFirstDayOfMonth()-> Date?{
        let comp = Calendar.current.dateComponents([.year, .month], from: self)
        let first = Calendar.current.date(from: comp)
        return first
    }
    
    /// 获取当月最后一天
    /// - Returns: 日期
    func fetchLastDayOfMonth()-> Date?{
        guard let range = Calendar.current.range(of: .day, in: .month, for: self) else { return nil }
        var components = Calendar.current.dateComponents([.year, .month], from: self)
        components.day = range.count
        components.hour = 23
        components.minute = 59
        components.second = 59
        return Calendar.current.date(from: components)
    }
    
    
    /// 获取当年的第一天
    /// - Parameter year: 年
    /// - Returns: 日期
    static func fetchFirstDayOfYear(_ year: Int)-> Date? {
        var com2 = DateComponents()
        com2.year = year
        com2.month = 1
        com2.day = 1
        com2.hour = 0
        com2.minute = 0
        com2.second = 01
        let last = Calendar.current.date(from: com2)
        return last
    }
    
    /// 获取当年的最后一天
    /// - Parameter year: 年
    /// - Returns: 日期
    static func fetchLastDayOfYear(_ year: Int)-> Date? {
        var com2 = DateComponents()
        com2.year = year
        com2.month = 12
        com2.day = 31
        com2.hour = 23
        com2.minute = 59
        com2.second = 59
        let last = Calendar.current.date(from: com2)
        return last
    }
    
    
    /// 获取本周的第一天
    /// - Returns: 日期
    func fetchFirstWeekDay()-> Date?{
        let temp = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: self)
        guard temp.weekday != nil, temp.hour != nil , temp.minute != nil else {
            return nil
        }
        var com = DateComponents()
        com.day = -(temp.weekday! - 1)
        com.hour = -temp.hour!
        com.minute = -temp.minute!
        
        let date = Calendar.current.date(byAdding: com, to: self)
        return date
    }
    
    /// 获取本周的最后一天
    /// - Returns: 日期
    func fetchLastWeekDay()-> Date?{
        let temp = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: self)
        guard temp.weekday != nil, temp.hour != nil , temp.minute != nil else {
            return nil
        }
        let dis = 7 - temp.weekday!
        let hhdis = 23 - temp.hour!
        let mmdis = 59 - temp.minute!
        var com = DateComponents()
        com.day = dis
        com.hour = hhdis
        com.minute = mmdis
        let date = Calendar.current.date(byAdding: com, to: self)
        return date
    }
    
    /// 根据年月创建时间
    static func createDateWith(_ year: Int,_ month: Int)-> Date?{
        var com2 = DateComponents()
        com2.year = year
        com2.month = month
        let last = Calendar.current.date(from: com2)
        return last
    }
    
    /// 获取当月有多少天
    /// - Returns: 天数
    func fetchCountDayOfMonth()->Int?{
        let range = Calendar.current.range(of: .day, in: .month, for: self)
        return range?.count
    }
    
    /// 下一天
    /// - Returns: 日期
    func nextDay()->Date?{
        var comp = DateComponents()
        comp.day = 1
        return Calendar.current.date(byAdding: comp, to: self)
    }
    
    /// 获取年
    func fetchYear()->Int {
        let year = Calendar.current.component(.year, from: self)
        return year
    }
    /// 获取月
    func fetchMonth()->Int {
        let month = Calendar.current.component(.month, from: self)
        return month
    }
    /// 获取日
    func fetchDay()->Int {
        let day = Calendar.current.component(.day, from: self)
        return day
    }
    
    /// 同一天的0点
    func fetchZero()-> Date?{
        let com = Calendar.current.dateComponents([.year,.month,.day], from: self)
        let zero = Calendar.current.date(from: com)
        return zero
    }
    /// 当天的24点
    func fetchFull()-> Date? {
        var com = Calendar.current.dateComponents([.year,.month,.day], from: self)
        com.hour = 23
        com.minute = 59
        com.second = 59
        let full = Calendar.current.date(from: com)
        return full
    }
    /// 根据星期几来获取
    /// 获取这个星期的所有日期
    func fetchDayForWeek()-> [Date]?{
        let temp = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: self)
        guard temp.weekday != nil, temp.hour != nil , temp.minute != nil else {
            return nil
        }
        var list = [Date]()
        for i in 1 ... 7 {
            var com = DateComponents()
            com.day = i - temp.weekday!
            com.hour = -temp.hour!
            com.minute = -temp.minute!
            com.second = -temp.second!
            if let date = Calendar.current.date(byAdding: com, to: self) {
                list.append(date)
            }
        }
        return list
    }
    /// 获取日期的所在的月份所有日期
    func fetchDayForMonth()->[Date]? {
        var list = [Date]()
        if let max = fetchCountDayOfMonth() {
            for i in 1 ... max {
                var com = Calendar.current.dateComponents([.year,.month], from: self)
                com.day = i
                if let target = Calendar.current.date(from: com) {
                    list.append(target)
                }
            }
        }
        return list
    }
    
    /// 判断是否为同一天
    func isSameDay(_ other: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: other)
    }
    
    /// 判断是否为同一个月
    func isSameMonth(_ other: Date) -> Bool {
        let result = Calendar.current.compare(self, to: other, toGranularity: .month)
        return result == .orderedSame
    }
    
    /// 以今天为基础 往后+ n天
    func todayTofutureWith(_ add: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: add, to: self)
    }
}

extension String {
    
    /// 转换成Date对象
    /// - Returns: Date对象
    func convertDate(_ format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        return formatter.date(from: self)
    }
}

protocol OKDateProtocol {
    var weeks_cn:Array<String> {get}
    var weekday_en:String {get}
    var weekday_cn:String {get}
    var weekday_en_short:String {get}
}

extension OKDateProtocol {
    
    var weeks_cn: Array<String> {
        return ["星期天","星期一","星期二","星期三","星期四","星期五","星期六"]
    }
}

extension Date:OKDateProtocol{
    
    var weekday_en_short: String {
        let weekday = Calendar.current.component(.weekday, from: self)
        return  Calendar.current.shortWeekdaySymbols[weekday - 1]
    }

    var weekday_cn: String {
        let weekday = Calendar.current.component(.weekday, from: self)
        return weeks_cn[weekday - 1]
    }

    var weekday_en: String {
        let weekday = Calendar.current.component(.weekday, from: self)
        return Calendar.current.weekdaySymbols[weekday - 1]
    }
}


