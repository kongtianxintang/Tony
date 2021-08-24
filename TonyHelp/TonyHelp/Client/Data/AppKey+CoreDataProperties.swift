/*
 @Desc: app的开启钥匙
 @Date: 2021/8/19
 */
import Foundation
import CoreData

extension AppKey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppKey> {
        return NSFetchRequest<AppKey>(entityName: "AppKey");
    }

    @NSManaged public var openid: String?

    public override func awakeFromInsert() {
        openid = "test";
    }
}
