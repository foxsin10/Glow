import UIKit

open class Layer: CAShapeLayer {
    let layout: Layout
    private var layers: [SkeletonBoneLayer] = []

    init(layout: SkeletonLayout) {
        self.layout = layout
        super.init()
        setup()
    }

    override init(layer: Any) {
        layout = SkeletonLayout()
        super.init(layer: layer)
        setup()
    }

    private func setup() {
        for key in self.layout.keys {
            let layer = SkeletonBoneLayer(bone: key.bone)
            layers.append(layer)
            self.addSublayer(layer)
            layer.frame = layout[key]
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
