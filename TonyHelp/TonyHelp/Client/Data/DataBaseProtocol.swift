/*
 @Desc: 数据库协议
 @Date: 2021/8/19
 */

import Foundation
import CoreData

protocol DBProtocol{
    static func deleteAll(className name:AnyClass,sortKey key:String);//删除这个类的所有元素
    static func fetchNSManagedObject(className name:AnyClass,sortKey key:String)->Array<NSFetchRequestResult>?;
    static func update();
    static func coreDataSave(with completeHandle:((_ isSave:Bool)->Void)?);
    static func insert(object:NSManagedObject);
    static func delete(object:NSManagedObject);//删除单个
}
