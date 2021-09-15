/*
 @Desc: 用户信息
 @Date: 2021/9/2
 */

import UIKit

class THUserCell: UITableViewCell {

    static let reuse = "user_cell"
    
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    private lazy var mShape = CAShapeLayer()
    
    //MARK: 生命周期
    override func awakeFromNib() {
        super.awakeFromNib()
        configureShape()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawShape()
    }
    
    //MARK: 对外方法暴露
    /// 设置 数据
    func setUser(_ bean: User){
        nickname.text = bean.fetchSurplus()
        numLabel.text = bean.fetchLastOption()
        mShape.strokeEnd = bean.fetchProgress()
        telLabel.text = bean.fetchTelPhone()
        nameLabel.text = bean.fetchNickname()
    }
    
}
//MARK: 私有方法
private extension THUserCell {
    /// 绘制进度
    func drawShape(){
        let radio = nickname.bounds.height / 2 + 4
        let path = UIBezierPath.init(roundedRect: nickname.bounds, cornerRadius: radio)
        mShape.path = path.cgPath
    }
    /// 设置进度条的一些基础属性
    func configureShape() {
        nickname.layer.addSublayer(mShape)
        mShape.fillColor = UIColor.clear.cgColor
        mShape.strokeColor = UIColor.green.cgColor
        mShape.lineWidth = 4
        mShape.lineCap = .round
    }
}
