import UIKit

extension UIBezierPath {
    convenience public init(bounds: CGRect, corners: [RectCorner: CGFloat]) {
        self.init()
        let leftTopRadius = corners[.topLeft] ?? 0
        let rightTopRadius = corners[.topRight] ?? 0
        let rightBottomRadius = corners[.bottomRight] ?? 0
        let leftBottomRadius = corners[.bottomLeft] ?? 0
        move(to: CGPoint(x: leftTopRadius, y: 0))
        addQuadCurve(to: CGPoint(x: 0, y: leftTopRadius), controlPoint: .zero)
        addLine(to: CGPoint(x: 0, y: bounds.height - leftBottomRadius))
        addQuadCurve(
            to: CGPoint(x: leftBottomRadius, y: bounds.height),
            controlPoint: CGPoint(x: 0, y: bounds.height)
        )
        addLine(to: CGPoint(x: bounds.width - rightBottomRadius, y: bounds.height))
        addQuadCurve(
            to: CGPoint(x: bounds.width, y: bounds.height - rightBottomRadius),
            controlPoint: CGPoint(x: bounds.width, y: bounds.height)
        )
        addLine(to: CGPoint(x: bounds.width, y: rightTopRadius))
        addQuadCurve(
            to: CGPoint(x: bounds.width - rightTopRadius, y: 0),
            controlPoint: CGPoint(x: bounds.width, y: 0)
        )
        close()
    }
}
