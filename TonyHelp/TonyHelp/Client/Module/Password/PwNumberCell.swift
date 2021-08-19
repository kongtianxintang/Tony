/*
 @Desc: 数字cell
 @Date: 2021/8/18
 */

import UIKit

class PwNumberCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    private lazy var mShape = CAShapeLayer()
    
    //todo: 可以优化 设置mshape的属性
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.addSublayer(mShape)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let minN = min(label.bounds.height, label.bounds.width) - 2.0;
        let midX = label.frame.width / 2.0;
        let midY = label.frame.height / 2.0;
        let point = CGPoint.init(x: midX, y: midY)
        let shape = CAShapeLayer()
        let path = UIBezierPath.init(arcCenter: point, radius: minN / 2.0, startAngle: 0, endAngle:CGFloat( 2.0 * .pi), clockwise: false)
        shape.path = path.cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.lightGray.cgColor
        shape.lineWidth = 2.0;
        shape.opacity = 0.5;
        label.layer.addSublayer(shape)
    }
    
   
}
