import UIKit

protocol LayoutKey {
    var keys: [SkeletonLayoutKey] { get }
    var hash: Int { get }
    var bone: SkeletonBone { get }
}

extension LayoutKey where Self: Hashable {
    var hash: Int { self.hashValue }
}

extension LayoutKey where Self: CaseIterable {
    var keys: [SkeletonLayoutKey] { Array(Self.allCases) }
}

class Layout {
    private var frames: [Int: CGRect] = [:]

    var size: CGSize = .zero
    var keys: [LayoutKey] = []

    private var shadowWidth: CGFloat = 0
    var superWidth: CGFloat {
        get {
            return shadowWidth
        }
        set {
            let oldValue = shadowWidth
            shadowWidth = newValue
            if oldValue != shadowSuperWidth { calculate() }
        }
    }

    init() {
        setup()
    }

    func setup() {
        calculate()
    }

    func calculate() {}

    func set(_ frame: CGRect, for key: SkeletonLayoutKey) {
        frames[key.hash] = frame
    }

    func get(_ key: SkeletonLayoutKey) -> CGRect {
         frames[key.hash] ?? CGRect.zero
    }

    subscript(key: SkeletonLayoutKey) -> CGRect {
        get { get(key) }
        set { set(newValue, for: key) }
    }
}

@_functionBuilder
enum LayoutBuilder {
    static func buildBlock(_ components: SkeletonLayout...) -> [SkeletonLayout] {
        return components
    }
}
