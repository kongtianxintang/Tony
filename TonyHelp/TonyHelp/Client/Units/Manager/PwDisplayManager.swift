/*
 @Description: 启动页面切换管理类
 @Date:  2021/8/19
 */
import UIKit

class PwDisplayManager {

    static let shared = PwDisplayManager();
    
    func displayInputPassword(){
        let root = THPasswordController();
         UIApplication.shared.keyWindow!.rootViewController = root;
    }
    
    func displayMain(){
        let root = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "root")
        UIApplication.shared.keyWindow!.rootViewController = root;
    }
    
}
