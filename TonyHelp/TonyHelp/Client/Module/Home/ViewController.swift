/*
 @Desc: scene
 @Date: 2021/8/18
 */

import UIKit
import CoreData
import Combine

class ViewController: UIViewController {

    //MARK: 底部菜单栏
    @IBOutlet weak var mMenuView: THTabbarMenu!
    @IBOutlet weak var mTableView: UITableView!
    private var mResultController: NSFetchedResultsController<User>?
    private var mSearchVC: UISearchController?
    
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
        navigationItem.title = "控制台"
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
        guard let controller = User.createResultsController("date",false) as? NSFetchedResultsController<User> else {
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
        var vc: UIViewController!
        switch alignment {
        case .Right:
            vc = THAddViewController()
        default:
            let resultVC = THResultsController()
            resultVC.delegate = self
            let svc = UISearchController.init(searchResultsController: resultVC)
            svc.searchResultsUpdater = self
            svc.delegate = self
            svc.searchBar.placeholder = "输入名字或电话号码"
            mSearchVC = svc
            vc = svc
        }
        present(vc, animated: true, completion: nil)
    }
}

//MARK:UITableViewDataSource
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let user = mResultController?.object(at: indexPath) {
            pushUserDetail(user)
        }
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
//MARK: UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultVC = searchController.searchResultsController as? THResultsController else { return }
        if let text = searchController.searchBar.text, text.count > 0 {
            if let objects = mResultController?.fetchedObjects {
                let array = objects.filter { obj in
                    if let name = obj.name {
                        if name.contains(text) {
                            return true
                        }
                    }
                    if let tel = obj.tel {
                        if tel.contains(text) {
                            return true
                        }
                    }
                    return false
                }
                resultVC.setData(array)
            }
        }else {
            resultVC.setData(nil)
        }
    }
}
//MARK: THResultsControllerDelegate
extension ViewController: THResultsControllerDelegate {
    func resultsControllerDidSelect(_ user: User) {
        mSearchVC?.dismiss(animated: true, completion: {[weak self] in
            self?.pushUserDetail(user)
            self?.mSearchVC = nil
        })
    }
    
    private func pushUserDetail(_ user: User){
        let vc = THDetailViewController()
        vc.setUser(user)
        show(vc, sender: nil)
    }
}
//MARK: UISearchControllerDelegate
extension ViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        mSearchVC = nil
    }
}
