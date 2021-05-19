import QuartzCore

public protocol AnimationProvider {
    var key: AnimationType { get }
    func prepareLayer(_ layer: CALayer)
    func makeAnimation() -> CAAnimation
}
