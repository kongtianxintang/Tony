/*
 @Description:底部导航
 @Date:  2021/8/23
 */

import UIKit


class THTabbarMenu: UIView {
    //MARK: 属性
    private lazy var mButton = UIButton()
    private lazy var mLeftBt = UIButton()
    private lazy var mRightBt = UIButton()
    private var isBounceAnimating: Bool = false
    private var isMenuOpen: Bool = false
    private var customNormalIconView: UIImageView?
    private var customSelectedIconView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
}

//MARK: 布局
private extension THTabbarMenu {
    
    func setupSubviews() {
        let subs: [UIView] = [mButton,
                              mLeftBt,
                              mRightBt]
        subs.forEach { it in
            addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
        }
        layoutBt()
        configureSubviews()
        
        commonInit()
    }
    
    func layoutBt() {
        mButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.center.equalToSuperview()
        }
        mLeftBt.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        mRightBt.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configureSubviews() {
        configureBt()
    }
    
    func configureBt() {
        mButton.addTarget(self, action: #selector(didClickMenuBt(_:)), for: .touchUpInside)
        mButton.setImage(UIImage.init(named: "icon_close"), for: .selected)
        mButton.setImage(UIImage.init(named: "icon_menu"), for: .normal)
        mButton.layer.cornerRadius = 22
    }
    
    func commonInit() {
        customNormalIconView = addCustomImageView(state: .normal)

        customSelectedIconView = addCustomImageView(state: .selected)
        customSelectedIconView?.alpha = 0

        mButton.setImage(UIImage(), for: .normal)
        mButton.setImage(UIImage(), for: .selected)
    }
}

//MARK: bt的点击事件
private extension THTabbarMenu {
    
    @objc func didClickMenuBt(_ sender: UIButton){
        guard !isBounceAnimating else { return }
        isBounceAnimating = true
        let isShow = !isMenuOpen
        tapBounceAnimation(duration: 0.5) { [weak self] _ in
            self?.isBounceAnimating = false
        }
        tapRotatedAnimation(0.3, isSelected: isShow)
    }
    
    func tapBounceAnimation(duration: TimeInterval, completion: ((Bool)->())? = nil) {
        transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5,
                       options: UIView.AnimationOptions.curveLinear,
                       animations: { () -> Void in
                        self.transform = CGAffineTransform(scaleX: 1, y: 1)
        },
                       completion: completion)
    }

    func tapRotatedAnimation(_ duration: Float, isSelected: Bool) {

        let addAnimations: (_ view: UIImageView, _ isShow: Bool) -> Void = { view, isShow in
            var toAngle: Float = 180.0
            var fromAngle: Float = 0
            var fromScale: Float = 1.0
            var toScale:Float = 0.2
            var fromOpacity: Float = 1
            var toOpacity: Float = 0
            if isShow == true {
                toAngle = 0
                fromAngle = -180
                fromScale = 0.2
                toScale = 1.0
                fromOpacity = 0
                toOpacity = 1
            }

            view.th_rotationAnimation(duration, toAngle.degrees, fromAngle.degrees)
            view.th_fadeAnimation(duration, toOpacity, fromOpacity)
            view.th_scaleAnimation(duration, toScale, fromScale)
        }

        if let customNormalIconView = self.customNormalIconView {
            addAnimations(customNormalIconView, !isSelected)
        }
        if let customSelectedIconView = self.customSelectedIconView {
            addAnimations(customSelectedIconView, isSelected)
        }

        self.isMenuOpen = isSelected
        self.mButton.alpha = isSelected ? 0.3: 1
    }
    
    func addCustomImageView(state: UIControl.State) -> UIImageView? {
        guard let image = mButton.image(for: state) else {
            return nil
        }

        let iconView = customize(UIImageView(image: image)) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentMode = .center
            $0.isUserInteractionEnabled = false
        }
        mButton.addSubview(iconView)

        // added constraints
        iconView.addConstraint(NSLayoutConstraint(item: iconView, attribute: .height, relatedBy: .equal, toItem: nil,
                                                  attribute: .height, multiplier: 1, constant: bounds.size.height))

        iconView.addConstraint(NSLayoutConstraint(item: iconView, attribute: .width, relatedBy: .equal, toItem: nil,
                                                  attribute: .width, multiplier: 1, constant: bounds.size.width))

        addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: iconView,
                                         attribute: .centerX, multiplier: 1, constant: 0))

        addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: iconView,
                                         attribute: .centerY, multiplier: 1, constant: 0))

        return iconView
    }
}




