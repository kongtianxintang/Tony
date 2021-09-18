/*
 @desc: 搜索结果展示
 @date: 2021/9/17
 */

import UIKit
import CoreData

protocol THResultsControllerDelegate: NSObjectProtocol {
    func  resultsControllerDidSelect(_ user: User)
}

class THResultsController: UITableViewController {

    private let mCellReuse = "results_cell"
    private var mResults: Array<User>?
    weak var delegate: THResultsControllerDelegate?
    
    deinit {
        print("--销毁-->\(self)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    //MARK: 外部方法
    func setData(_ array: Array<User>?){
        mResults = array
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let result = mResults, result.count > 0 else { return 0 }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result = mResults else { return 0 }
        return result.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mCellReuse, for: indexPath)
        if let user = mResults?[indexPath.row] {
            cell.textLabel?.text = user.name
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = mResults?[indexPath.row] {
            delegate?.resultsControllerDidSelect(user)
        }
    }
}

//MARK: 私有方法
private extension THResultsController {
    /// 设置table view 的基础配置
    func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: mCellReuse)
        tableView.rowHeight = 56
        tableView.tableFooterView = UIView()
    }
}
