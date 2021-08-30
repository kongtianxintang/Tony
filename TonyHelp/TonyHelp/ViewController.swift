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
        configureSubviews()
        test()
    }


}
//MARK: 基本设置
private extension ViewController {
    /// view的代理 及 其他的设置
    func configureSubviews() {
        mMenuView.delegate = self
    }
}

//MARK: 测试代码
private extension ViewController {
    
    func test(){
        let list = User.fetchObject("date")
        print("获取到->\(list)")
    }
}
//MARK: THTabbarMenuDelegate
extension ViewController: THTabbarMenuDelegate {
    func menuViewDidClick(_ alignment: THMenuLoaderAlignment, _ menu: THTabbarMenu) {
        print("--点击了底部导航 位置-->\(alignment)")
    }
}
