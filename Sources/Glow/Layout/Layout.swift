import UIKit

open class Layout {
    private var frames: [Int: CGRect] = [:]

    public var size: CGSize = .zero
    public var keys: [LayoutKey] = []

    private var shadowWidth: CGFloat = 0
    public var superWidth: CGFloat {
        get {
            return shadowWidth
        }
        set {
            let oldValue = shadowWidth
            shadowWidth = newValue
            if oldValue != shadowWidth { calculate() }
        }
    }

    public init() {
        calculate()
    }

    open func calculate() {}

    public final func set(_ frame: CGRect, for key: LayoutKey) {
        frames[key.hash] = frame
    }

    public final func get(_ key: LayoutKey) -> CGRect {
         frames[key.hash] ?? CGRect.zero
    }

    public subscript(key: LayoutKey) -> CGRect {
        get { get(key) }
        set { set(newValue, for: key) }
    }
}
