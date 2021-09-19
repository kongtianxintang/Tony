/*
 @desc: 用户的信息操作页面
 @date: 2021/9/17
 */

import UIKit

class THDetailViewController: UIViewController {

    //MARK: 属性
    private var mUser: User?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigure()
    }
    @IBAction func didClickReduce(_ sender: UIButton) {
        guard let user = mUser else { return }
        user.surplus -= 1
        if let re = Record.createEntiy() as? Record{
            re.date = Date()
            re.type = 1
            re.desc = "消费一次"
            user.addToRecord(re)
        }
        Record.coreDataSave {[unowned self] flag in
            self.tableView.reloadData()
            self.configureHeaderView()
        }
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
   
    /// 基础配置
    func defaultConfigure() {
        configureTableView()
        configureData()
    }
    /// 配置tableview
    func configureTableView(){
        tableView.layer.cornerRadius = 4
        let nib = UINib.init(nibName: "THRecordCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: THRecordCell.reuse)
        attachTableViewHeaderView()
    }
    /// 根据user 设置ui
    func configureData(){
        guard let user = mUser else { return }
        navigationItem.title = user.name
    }
    /// 设置页头
    func attachTableViewHeaderView(){
        let header = THDetailHeaderView()
        let height: CGFloat = 156
        header.frame.size.height = height
        tableView.tableHeaderView = header
        configureHeaderView()
    }
    /// 设置页头的数据
    func configureHeaderView(){
        guard let header = tableView.tableHeaderView as? THDetailHeaderView else { return  }
        if let bean = mUser {
            header.infoView.setData(bean)
        }
    }
}

//MARK: 代理方法
extension THDetailViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = mUser?.record else { return 0 }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let set = mUser?.record else {
            return 0
        }
        return set.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: THRecordCell.reuse, for: indexPath)
        if let bean = mUser?.record?.object(at: indexPath.row) as? Record{
            cell.textLabel?.text = bean.fetchRecordDesc()
        }
        return cell
    }
}
