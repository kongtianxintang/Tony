/*
 @desc: 用户的信息操作页面
 @date: 2021/9/17
 */

import UIKit

class THDetailViewController: UIViewController {

    //MARK: 属性
    private var mUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDatasource()
    }
}
//MARK: 对外暴露方法
extension  THDetailViewController {
    /// 设置用户信息
    func setUser(_ user: User){
        mUser = user
    }
}
//MARK: 私有方法
private  extension THDetailViewController {
    /// 获取数据
    func loadDatasource(){
        
    }
}

//MARK: 代理方法
extension THDetailViewController: UITableViewDataSource,UITableViewDelegate {
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
