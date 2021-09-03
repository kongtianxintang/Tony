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
    private var mResultController: NSFetchedResultsController<User>?
    
    //MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        fetchResults()
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
        mTableView.rowHeight = 96
        mTableView.separatorStyle = .none
    }
}

//MARK: 数据
private extension ViewController {
    /// 获取数据
    func fetchResults(){
        guard let controller = User.createResultsController("date") as? NSFetchedResultsController<User> else {
            PwToast.showToast(text: "创建数据获取对象失败")
            return
        }
        do {
            try controller.performFetch()
            controller.delegate = self
            mResultController = controller
        } catch let error {
            PwToast.showToast(text: "获取数据失败:\(error)")
        }
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
        guard let sections = mResultController?.sections else { return 0 }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = mResultController?.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: THUserCell.reuse, for: indexPath) as! THUserCell
        if  let user = mResultController?.object(at: indexPath) {
            cell.setUser(user)
        }
        return cell
    }
}

//MARK: NSFetchedResultsControllerDelegate
extension ViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            mTableView.reloadData()
        case .insert:
            if newIndexPath != nil {
                mTableView.insertRows(at: [newIndexPath!], with: .automatic)
            }
        case .move:
            mTableView.reloadData()
        case .update:
            if indexPath != nil {
                mTableView.reloadRows(at: [indexPath!], with: .automatic)
            }
        @unknown default:
            mTableView.reloadData()
        }
    }
}
