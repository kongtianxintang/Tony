/*
 @Desc: scene
 @Date: 2021/8/18
 */

import UIKit
import CoreData

class ViewController: UIViewController {

    //MARK: 底部菜单栏
    @IBOutlet weak var mMenuView: THTabbarMenu!
    @IBOutlet weak var mTableView: UITableView!
    private var mResultController: NSFetchedResultsController<NSFetchRequestResult>?
    
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
        navigationItem.title = "主页"
        configureMenuView()
        configureTableView()
    }
    /// 配置menu view
    func  configureMenuView(){
        mMenuView.delegate = self
    }
    /// 配置table view
    func configureTableView(){
        let nib = UINib.init(nibName: "THUserCell", bundle: .main)
        mTableView.register(nib, forCellReuseIdentifier: THUserCell.reuse)
        mTableView.tableFooterView = UIView()
    }
}

//MARK: 
private extension ViewController {
    
    func test(){
        let list = User.fetchObject("date")
        print("获取到->\(list)")
    }
    
}
//MARK: THTabbarMenuDelegate
extension ViewController: THTabbarMenuDelegate {
    func menuViewDidClick(_ alignment: THMenuLoaderAlignment, _ menu: THTabbarMenu) {
        switch alignment {
        case .Right:
            let  vc = THAddViewController()
            present(vc, animated: true, completion: nil)
        default:
            //todo: 去搜索页面
            break
        }
    }
}

//MARK:UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
}
