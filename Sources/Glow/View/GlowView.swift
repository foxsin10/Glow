import UIKit

open class GlowView: UIView {
    public let direction: Direction
    public let animationProvider: AnimationProvider

    private let bonesView = UIView()
    private let bonesMask = UIView()
    private var layers: [Layer] = []
    private let layouts: [Layout]
    private let gradientLayer = CAGradientLayer()

    public var foregroundColor: UIColor = .white {
        didSet {
            updateSkeletonColor()
        }
    }

    convenience public init(
        layout: Layout,
        direction: Direction = .vertical,
        offset: CGFloat = 0,
        animationProvider: AnimationProvider = DarkShimmer()
    ) {
        self.init(direction: direction,
                  offset: offset,
                  animationProvider: animationProvider,
                  layouts: { layout })
    }

    private let contentOffset: CGFloat
    public init(
        direction: Direction = .vertical,
        offset: CGFloat = 0,
        animationProvider: AnimationProvider = DarkShimmer(),
        @LayoutBuilder layouts: () -> [Layout]
    ) {
        contentOffset = offset
        self.layouts = layouts()
        self.direction = direction
        self.animationProvider = animationProvider
        super.init(frame: CGRect.zero)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setup() {
        addSubview(bonesView)
        bonesView.mask = bonesMask
        bonesView.layer.addSublayer(gradientLayer)
        gradientLayer.isHidden = true
        updateSkeletonColor()
        buildSkeletonLayer()
    }

    open func buildSkeletonLayer() {
        layers.forEach { $0.removeFromSuperlayer() }
        layers.removeAll()
        var offset: CGFloat = 0
        offset += contentOffset

        for layout in self.layouts {
            let layer = Layer(layout: layout)

            layers.append(layer)
            bonesMask.layer.addSublayer(layer)

            layer.frame = CGRect(
                x: direction == .vertical ? 0 : offset,
                y: direction == .vertical ? offset : 0,
                width: layout.size.width,
                height: layout.size.height
            )
            let delta = (direction == .vertical ? layout.size.height : layout.size.width)
            offset += delta
        }
    }

    private func updateSkeletonColor() {
        bonesView.backgroundColor = foregroundColor
        gradientLayer.backgroundColor = foregroundColor.cgColor
    }

    public var state: AnimationState = .idle {
        didSet { ensureAnimationStatus() }
    }

    open func ensureAnimationStatus() {
        switch state {
        case .idle:
            isHidden = true
            stopAnimation()

        case .playing:
            restartAnimation()
            isHidden = false
        }
    }

    open func startAnimation() {
        switch animationProvider.key {
        case .glow:
            animationProvider.prepareLayer(bonesView.layer)
            let animation = animationProvider.makeAnimation()
            bonesView.layer.add(animation, forKey: "glow")

        case .shimmer:
            animationProvider.prepareLayer(gradientLayer)
            let animation = animationProvider.makeAnimation()
            gradientLayer.add(animation, forKey: "shimmer")
        }
    }

    open func stopAnimation() {
        switch animationProvider.key {
        case .glow: bonesView.layer.removeAllAnimations()
        case .shimmer: gradientLayer.removeAllAnimations()
        }
    }

    public func restartAnimation() {
        stopAnimation()
        startAnimation()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        bonesView.frame = bounds
        bonesMask.frame = bonesView.bounds
        gradientLayer.frame = bonesView.bounds

        calculateLayouts(layoutwidth: bounds.size.width)
        buildSkeletonLayer()
    }

    private func calculateLayouts(layoutwidth: CGFloat) {
        layouts.forEach({ $0.superWidth = layoutwidth })
    }
}
