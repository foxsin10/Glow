import UIKit

struct GlowingAnimation: AnimationProvider {
    var key: AnimationType { .glow }
    func prepareLayer(_ layer: CALayer) {}

    func makeAnimation() -> CAAnimation {
        let opacityPointAnim = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.backgroundColor))
        opacityPointAnim.fromValue = UIColor.white.withAlphaComponent(0.1).cgColor
        opacityPointAnim.toValue = UIColor.lightGray.cgColor
        opacityPointAnim.duration = 0.6
        opacityPointAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        opacityPointAnim.repeatCount = .infinity
        opacityPointAnim.autoreverses = true
        opacityPointAnim.isRemovedOnCompletion = false

        return opacityPointAnim
    }
}
