import UIKit

open class Layer: CAShapeLayer {
    let layout: Layout
    private var layers: [BoneLayer] = []

    public init(layout: Layout) {
        self.layout = layout
        super.init()
        setup()
    }

    override public init(layer: Any) {
        layout = Layout()
        super.init(layer: layer)
        setup()
    }

    open func setup() {
        for key in self.layout.keys {
            let layer = BoneLayer(bone: key.bone)
            layers.append(layer)
            addSublayer(layer)
            layer.frame = layout[key]
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
