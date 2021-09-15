/*
 @desc: 操作记录扩展
 @date: 2021/9/15
 */

import UIKit

extension Record {
    /// type == 1 消费 2 充值
    
    /// 操作说明
    /// 例子: 2021/2/15消费一次
    func fetchRecordDesc()->  String?{
        guard let dateStr = date?.fetchFormatTime("yyyy年MM月dd日") else { return nil }
        var typeStr: String!
        switch type {
        case 1:
            typeStr = "消费"
        case 2:
            typeStr = "充值"
        default:
            typeStr = "初始化"
        }
        return dateStr + typeStr
    }
}
