/*
 @desc: 用户的信息操作记录 页头信息展示
 @date: 2021/9/19
 */

import UIKit

class THUserDetailView: UIView {
    //MARK: 属性
    private lazy var mCircleShape = CAShapeLayer()
    private lazy var mProgressLabel = UILabel()
    private lazy var mNicknameLabel = UILabel()
    private lazy var mTelLabel = UILabel()
    private lazy var mRecordLabel = UILabel()
    
    //MARK: 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawShape()
    }
    
    //MARK: 对外暴露方法
    func setData(_ bean: User){
        progressAnimation(bean.fetchProgress())
        mProgressLabel.text = bean.fetchSurplus()
        mNicknameLabel.text = bean.fetchNickname()
        mTelLabel.text = bean.fetchTelPhone()
        mRecordLabel.text = bean.fetchLastOption()
        mCircleShape.strokeColor = bean.fetchProgressColor()
    }
}

//MARK: 私有方法
private extension  THUserDetailView {
    /// 布局
    func initUI(){
        let subs: [UIView] = [mProgressLabel,
                              mNicknameLabel,
                              mTelLabel,
                              mRecordLabel]
        subs.forEach { it in
            addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
        }
        
        mProgressLabel.font = UIFont.systemFont(ofSize: 14)
        mProgressLabel.adjustsFontSizeToFitWidth = true
        mProgressLabel.textAlignment = .center
        mProgressLabel.snp.makeConstraints { maker in
            maker.top.left.equalToSuperview().offset(12)
            maker.bottom.equalToSuperview().offset(-12)
            maker.width.equalTo(mProgressLabel.snp.height)
        }
        
        mNicknameLabel.textColor = UIColor.systemGray
        mNicknameLabel.font = UIFont.systemFont(ofSize: 14)
        mNicknameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(mProgressLabel.snp.top)
            maker.right.equalToSuperview().offset(-24)
        }
        
        mTelLabel.font = UIFont.systemFont(ofSize: 14)
        mTelLabel.textColor = UIColor.systemGray2
        mTelLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().offset(-24)
        }
        
        mRecordLabel.font = UIFont.systemFont(ofSize: 12)
        mRecordLabel.textColor = UIColor.systemGray3
        mRecordLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(mProgressLabel.snp.bottom)
            maker.right.equalToSuperview().offset(-24)
        }
        
        configureShape()
    }
    
    /// 进度条
    func drawShape(){
        let path = UIBezierPath.init(roundedRect: mProgressLabel.bounds, cornerRadius: mProgressLabel.bounds.width / 2)
        mCircleShape.path = path.cgPath
    }
    
    /// 设置进度条的一些基础属性
    func configureShape() {
        mProgressLabel.layer.addSublayer(mCircleShape)
        mCircleShape.fillColor = UIColor.clear.cgColor
        mCircleShape.strokeColor = UIColor.green.cgColor
        mCircleShape.lineWidth = 4
        mCircleShape.lineCap = .round
    }
    
    /// 进度的动画
    func progressAnimation(_ end: CGFloat){
        let ani = CABasicAnimation.init(keyPath: "strokeEnd")
        ani.fromValue = 0
        ani.toValue = end
        ani.duration = 1
        ani.isRemovedOnCompletion = false
        ani.fillMode = .forwards
        mCircleShape.add(ani, forKey: nil)
    }
}
