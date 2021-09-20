/*
 @desc: 用户的信息操作记录
 @date: 2021/9/18
 */

import UIKit

class THRecordCell: UITableViewCell {

    //MARK: 属性
    static let reuse = "record_cell"
    private lazy var mTopLine = CAShapeLayer()
    private lazy var mBottomLine = CAShapeLayer()
    private lazy var mStatusView = UIView()
    private lazy var mDescLabel = UILabel()
    private lazy var mBgShape = CAShapeLayer()
    private lazy var mRadiusType: THCellRadiusType = .None
    
    //MARK: 生命周期
    override func awakeFromNib() {
        super.awakeFromNib()
        initLayer()
        initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawLine()
        drawBgShape()
    }
    
    //MARK: 对外暴露方法
    func setData(_ bean: Record?,_ current: Bool,_ type: THCellRadiusType){
        mDescLabel.text = bean?.fetchRecordDesc()
        switch type {
        case .Top:
            mTopLine.opacity = 0
            mBottomLine.opacity = 1
        case .Bottom:
            mTopLine.opacity = 1
            mBottomLine.opacity = 0
        default:
            mTopLine.opacity = 1
            mBottomLine.opacity = 1
        }
        mRadiusType = type
    }
    
    //MARK: 私有方法
    private func initUI(){
        let subs: [UIView] = [mStatusView,mDescLabel]
        subs.forEach { it in
            contentView.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
        }
        mStatusView.layer.cornerRadius = 6
        mStatusView.backgroundColor = UIColor.green
        mStatusView.snp.makeConstraints { maker in
            maker.width.height.equalTo(12)
            maker.left.equalToSuperview().offset(24)
            maker.centerY.equalToSuperview()
        }
        
        mDescLabel.font = UIFont.systemFont(ofSize: 14)
        mDescLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalTo(mStatusView.snp.right).offset(12)
            maker.right.equalToSuperview().offset(-12)
        }
    }
    
    private func initLayer(){
        backgroundColor = UIColor.clear
        contentView.layer.addSublayer(mBgShape)
        mBgShape.fillColor = UIColor.white.cgColor
        contentView.backgroundColor = UIColor.clear
        
        let subs: [CAShapeLayer] = [mTopLine,mBottomLine]
        subs.forEach { it in
            contentView.layer.addSublayer(it)
            it.lineWidth = 2
            it.strokeColor = UIColor.systemGray6.cgColor
        }
    }
    
    private func drawLine(){
        let y = bounds.height / 2
        let x: CGFloat = 24 + 6
        let point = CGPoint.init(x: x, y: y)
        
        let topStart = CGPoint.init(x: x, y: 0)
        let topPath = UIBezierPath()
        topPath.move(to: topStart)
        topPath.addLine(to: point)
        mTopLine.path = topPath.cgPath
        
        let bottomEnd = CGPoint.init(x: x, y: bounds.height)
        let bottomPath = UIBezierPath()
        bottomPath.move(to: point)
        bottomPath.addLine(to: bottomEnd)
        mBottomLine.path = bottomPath.cgPath
    }
    
    private func drawBgShape(){
        let padding: CGFloat = 8
        let point = CGPoint.init(x: padding, y: 0)
        let size = CGSize.init(width: contentView.bounds.width - padding * 2, height: contentView.bounds.height)
        let rect = CGRect.init(origin: point, size: size)
        let path = rect.th_radiusPath(mRadiusType, 4)
        mBgShape.path = path
    }
    
}
