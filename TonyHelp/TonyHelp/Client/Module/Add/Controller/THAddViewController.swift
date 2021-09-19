/*
 @Desc: 添加
 @Date: 2021/9/2
 */

import UIKit

class THAddViewController: UIViewController {

    //MARK: 属性
    @IBOutlet weak var mNickname: UITextField!
    @IBOutlet weak var mTelTF: UITextField!
    @IBOutlet weak var mNumTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    /// 确定按钮
    @IBAction func didClickSubmitBt(_ sender: UIButton) {
        guard let nickname = mNickname.text,
              nickname.count > 0 else {
            PwToast.showToast(text: "请输入姓名")
            return
        }
        guard let tel = mTelTF.text,
              tel.count > 0 else {
            PwToast.showToast(text: "请输入电话号码")
            return
        }
        guard let numStr = mNumTF.text,
              numStr.count > 0,
              let num = Int64(numStr) else {
            PwToast.showToast(text: "请输入次数")
            return
        }
        var id: Int64 = 1
        if let count = User.fetchObject("id")?.count {
            id = Int64(count + 1)
        }
        guard let entiy = User.createEntiy() as? User else {
            PwToast.showToast(text: "创建entiy失败")
            return
        }
        entiy.id = id
        entiy.date = Date()
        entiy.name = nickname
        entiy.tel = tel
        entiy.surplus = num
        entiy.total = num
        
        User.coreDataSave {[weak self] flag in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
}
