/*
 @Desc: scene
 @Date: 2021/8/18
 */

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let key = UIWindow.init(frame: UIScreen.main.bounds)
        window = key
        key.backgroundColor = UIColor.white
        window!.makeKeyAndVisible()
        PwDisplayManager.shared.displayInputPassword()
        
        return true
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TonyHelp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
        
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                PwToast.showToast(text:"保存成功")
            } catch {
                
            }
        }
    }
}

