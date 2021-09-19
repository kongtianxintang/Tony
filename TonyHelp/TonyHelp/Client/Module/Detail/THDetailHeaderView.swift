/*
 @desc: 用户的信息操作记录 页头信息展示
 @date: 2021/9/19
 */

import UIKit

class THDetailHeaderView: UIView {

    //MARK: 属性
    private(set) lazy var infoView = THUserDetailView()
    
    //MARK: 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }

}

//MARK: 私有方法
private extension THDetailHeaderView {
    func initUI(){
        let subs: [UIView] = [infoView]
        subs.forEach { it in
            addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
        }
        infoView.snp.makeConstraints { maker in
            maker.top.left.equalToSuperview().offset(8)
            maker.bottom.right.equalToSuperview().offset(-8)
        }
        infoView.layer.cornerRadius = 4
        infoView.clipsToBounds = true
        infoView.backgroundColor = UIColor.white
    }
}
