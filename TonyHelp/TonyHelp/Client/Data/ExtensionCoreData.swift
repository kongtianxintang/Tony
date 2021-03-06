/*
 @Desc: 对NSManagedObject对象扩展
 @Date: 2021/8/19
 */
import Foundation
import UIKit
import CoreData

extension NSManagedObject:DBProtocol {
    
    //MARK:创建entity
    final class func createEntity(className name:AnyClass)->NSManagedObject?{
        guard let context = returnContext() else { assertionFailure("context 为 空");return nil};
        let entity = NSEntityDescription.insertNewObject(forEntityName: NSStringFromClass(name), into: context)
        return entity;
    }
    /// 创建 插入的entity
    static func createEntiy()-> NSManagedObject?{
        guard let context = returnContext() else { return nil }
        let tName = NSStringFromClass(self)
        let entity = NSEntityDescription.insertNewObject(forEntityName: tName, into: context)
        return entity
    }
    
    //MARK:删除所有这个类所有元素
    static func deleteAll(className name:AnyClass,sortKey key:String){
        guard let context = returnContext() else { assertionFailure("context 为 空");return  };
        if let list = fetchNSManagedObject(className: name, sortKey: key){
            for item in list {
                if let tObject = item as? NSManagedObject {
                    context.delete(tObject)
                }
            }
            coreDataSave(with: nil);
        }
    }
    
    //MARK:删除单个
    static func delete(object:NSManagedObject){
        guard let context = returnContext() else {assertionFailure("context 为 空");return};
            context.delete(object)
        coreDataSave(with: nil);
    }
    
    //MARK:查询
    static func fetchNSManagedObject(className name:AnyClass,sortKey key:String)->Array<NSFetchRequestResult>?{
        guard let context = returnContext() else { assertionFailure("context 为 空");return nil };
        let tName = NSStringFromClass(name)
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName:tName);
        let sort = NSSortDescriptor.init(key: key, ascending: true)
        request.sortDescriptors = [sort]
        let fetchController = NSFetchedResultsController.init(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchController.performFetch();
            return fetchController.fetchedObjects
        } catch {
            assertionFailure("fetch错误=\(error)")
            return nil;
        }
    }
    
    //MARK: 根据谓词获取结果
    static func fetchNSManagedObject(_ predicate: NSPredicate,_ sortKey: String?,_ ascending: Bool = true )-> Array<NSFetchRequestResult>? {
        guard let context = returnContext() else {
            assertionFailure("context 为 空")
            return nil
        }
        let tName = NSStringFromClass(self)
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName:tName)
        request.predicate = predicate
        if sortKey != nil {
            let sort = NSSortDescriptor.init(key: sortKey, ascending: ascending)
            request.sortDescriptors = [sort]
        }
        let fetchController = NSFetchedResultsController.init(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchController.performFetch()
            return fetchController.fetchedObjects
        } catch {
            assertionFailure("fetch错误=\(error)")
            return nil
        }
    }
    
    //MARK: 获取fetch controller
    static func createResultsController(_ sortKey: String,_ ascending: Bool)-> NSFetchedResultsController<NSFetchRequestResult>?{
        guard let context = returnContext() else { return nil }
        let tName = NSStringFromClass(self)
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName:tName);
        let sort = NSSortDescriptor.init(key: sortKey, ascending: ascending)
        request.sortDescriptors = [sort]
        let fetchController = NSFetchedResultsController.init(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchController
    }
    
    //MARK: 查询
    static func fetchObject(_ sortKey: String)-> Array<NSFetchRequestResult>? {
        guard let context = returnContext() else { return nil }
        let tName = NSStringFromClass(self)
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName:tName);
        let sort = NSSortDescriptor.init(key: sortKey, ascending: true)
        request.sortDescriptors = [sort]
        let fetchController = NSFetchedResultsController.init(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchController.performFetch()
            return fetchController.fetchedObjects
        } catch {
            assertionFailure("fetch错误=\(error)")
            return nil
        }
    }
    //MARK:更新
    static func update(){
        coreDataSave(with: nil);
    }
    
    //MARK:保存
    static func coreDataSave(with completeHandle:((_ isSave:Bool)->Void)?){
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            let context = delegate.persistentContainer.viewContext;
            if context.hasChanges {
                do {
                    try context.save();
                    if completeHandle != nil {
                        completeHandle!(true);
                    }
                } catch  {
                    if completeHandle != nil {
                        completeHandle!(false);
                    }
                    assertionFailure("数据库保存失败");
                }
            }
        }
    }
    
    //MARK:插入
    static func insert(object:NSManagedObject){
        coreDataSave(with: nil);
    }
    
    class func returnContext()->NSManagedObjectContext?{
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            let context = delegate.persistentContainer.viewContext
            return context;
        }
        return nil;
    }
    
}
