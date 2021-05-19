import UIKit

enum DefaultBone: PathBuilder {
    case rect
    case circle
    case singleLine(width: CGFloat, cornerRadius: CGFloat)
    //swiftlint:disable enum_case_associated_values_count
    case multipleLine(count: Int, width: CGFloat, cornerRadius: CGFloat, spacing: CGFloat, lastPercent: CGFloat)
    //swiftlint:ensable enum_case_associated_values_count
    case dashRect(count: Int, cornerRadius: CGFloat, spacing: CGFloat, direction: Direction = .horizontal)

    case roundedRect(cornerRadius: CGFloat)
    case cornerRect([RectCorner: CGFloat])
}
