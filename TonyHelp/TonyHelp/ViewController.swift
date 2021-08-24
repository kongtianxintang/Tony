/*
 @Desc: scene
 @Date: 2021/8/18
 */

import UIKit

class ViewController: UIViewController {

    //MARK: 底部菜单栏
    @IBOutlet weak var mMenuView: THTabbarMenu!
    
    
    //MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }


}

//MARK: 测试代码
private extension ViewController {
    
    func test(){
        let list = User.fetchObject("date")
        print("获取到->\(list)")
    }
}

