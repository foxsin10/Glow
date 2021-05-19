import UIKit

public struct DarkShimmer: AnimationProvider {
    public init() {}

    public var key: AnimationType { .shimmer }
    public func prepareLayer(_ layer: CALayer) {
        guard let gradientLayer = layer as? CAGradientLayer else { return }
        gradientLayer.isHidden = false
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.withAlphaComponent(0.1).cgColor,
            UIColor.clear.cgColor
        ]
    }

    public func makeAnimation() -> CAAnimation {
        let startPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.startPoint))
        startPointAnim.fromValue = CGPoint(x: -1, y: -1)
        startPointAnim.toValue = CGPoint(x: 1, y: 1)
        startPointAnim.isRemovedOnCompletion = false

        let endPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.endPoint))
        endPointAnim.fromValue = CGPoint(x: 0, y: 0)
        endPointAnim.toValue = CGPoint(x: 2, y: 2)
        endPointAnim.isRemovedOnCompletion = false

        let animGroup = CAAnimationGroup()
        animGroup.animations = [startPointAnim, endPointAnim]
        animGroup.duration = 1.5
        animGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animGroup.repeatCount = .infinity
        animGroup.isRemovedOnCompletion = false

        return animGroup
    }
}
