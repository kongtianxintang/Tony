/*
 @desc: 用户信息 扩展
 @date: 2021/9/15
 */

import UIKit

extension User {
    /// 获取剩余次数
    func fetchSurplus()-> String{
        return "剩余\(surplus)次"
    }
    /// 获取剩余进度
    func fetchProgress()-> CGFloat{
        let value = CGFloat(surplus) / CGFloat(total)
        return value
    }
    /// 获取进度外显示的颜色
    func fetchProgressColor() -> CGColor {
        var color: UIColor = UIColor.blue
        let value = fetchProgress()
        switch value {
        case 0 ..< 0.3:
            color = UIColor.red
        case 0.3 ..< 0.6:
            color = UIColor.green
        default:
            color = UIColor.blue
        }
        return color.cgColor
    }
    /// 获取最近一次操作记录
    func fetchLastOption()-> String?{
        guard let last = record?.lastObject as? Record else {
            if let dateStr = date?.fetchFormatTime("yyyy年MM月dd日") {
                return dateStr + "创建"
            }
            return nil
        }
        return last.fetchRecordDesc()
    }
    /// 获取电话号码
    func fetchTelPhone()-> String?{
        guard let str = tel else { return nil }
        return "电话号码:\(str)"
    }
    /// 获取昵称
    func fetchNickname()-> String?{
        guard let str  = name else { return nil }
        return "姓名:\(str)"
    }
}
