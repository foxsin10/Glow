import UIKit

public protocol LayoutKey {
    var keys: [LayoutKey] { get }
    var hash: Int { get }
    var bone: PathBuilder { get }
}

public extension LayoutKey where Self: Hashable {
    var hash: Int { self.hashValue }
}

public extension LayoutKey where Self: CaseIterable {
    var keys: [LayoutKey] { Array(Self.allCases) }
}
