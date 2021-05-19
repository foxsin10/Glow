import UIKit

extension UIBezierPath {
    convenience public init(bounds: CGRect, corners: [RectCorner: CGFloat]) {
        self.init()
        let leftTopRadius = corners[.topLeft] ?? 0
        let rightTopRadius = corners[.topRight] ?? 0
        let rightBottomRadius = corners[.bottomRight] ?? 0
        let leftBottomRadius = corners[.bottomLeft] ?? 0
        self.move(to: CGPoint(x: leftTopRadius, y: 0))
        self.addQuadCurve(to: CGPoint(x: 0, y: leftTopRadius), controlPoint: .zero)
        self.addLine(to: CGPoint(x: 0, y: bounds.height - leftBottomRadius))
        self.addQuadCurve(
            to: CGPoint(x: leftBottomRadius, y: bounds.height),
            controlPoint: CGPoint(x: 0, y: bounds.height)
        )
        self.addLine(to: CGPoint(x: bounds.width - rightBottomRadius, y: bounds.height))
        self.addQuadCurve(
            to: CGPoint(x: bounds.width, y: bounds.height - rightBottomRadius),
            controlPoint: CGPoint(x: bounds.width, y: bounds.height)
        )
        self.addLine(to: CGPoint(x: bounds.width, y: rightTopRadius))
        self.addQuadCurve(
            to: CGPoint(x: bounds.width - rightTopRadius, y: 0),
            controlPoint: CGPoint(x: bounds.width, y: 0)
        )
        self.close()
    }
}
