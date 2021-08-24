/*
 @Description: view的扩展函数
 @Date:  2021/8/24
 */

import UIKit

// MARK: helpers
func customize<Type>(_ value: Type, block: (_ object: Type) -> Void) -> Type {
    block(value)
    return value
}

extension UIView {
    var angleZ: Float {
        return atan2(Float(transform.b), Float(transform.a)).radians
    }
}

//MARK: 动画扩展
extension UIView {
    
    /// 旋转动画
    func th_rotationAnimation(_ duration: Float,_ toValue: Float,_ fromValue: Float){
        let rotation = customize(CABasicAnimation(keyPath: "transform.rotation")) {
            $0.duration = TimeInterval(duration)
            $0.toValue = toValue
            $0.fromValue = fromValue
            $0.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        self.layer.add(rotation, forKey: nil)
    }
    /// 透明度动画
    func th_fadeAnimation(_ duration: Float,_ toValue: Float,_ fromValue: Float) {
        let fade = customize(CABasicAnimation(keyPath: "opacity")) {
            $0.duration = TimeInterval(duration)
            $0.fromValue = fromValue
            $0.toValue = toValue
            $0.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            $0.fillMode = CAMediaTimingFillMode.forwards
            $0.isRemovedOnCompletion = false
        }
        self.layer.add(fade, forKey: nil)
    }
    /// 缩放动画
    func th_scaleAnimation(_ duration: Float,_ toValue: Float,_ fromValue: Float){
        let scale = customize(CABasicAnimation(keyPath: "transform.scale")) {
            $0.duration = TimeInterval(duration)
            $0.toValue = toValue
            $0.fromValue = fromValue
            $0.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        self.layer.add(scale, forKey: nil)
    }
}
