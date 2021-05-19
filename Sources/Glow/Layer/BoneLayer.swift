import UIKit

public class BoneLayer: CAShapeLayer {
    private let bone: PathBuilder
    public init(bone: PathBuilder) {
        self.bone = bone
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSublayers() {
        super.layoutSublayers()
        path = bone.path(of: bounds).cgPath
    }
}
