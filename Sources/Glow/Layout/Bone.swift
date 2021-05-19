import UIKit

public enum Bone {
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

extension Bone: PathBuilder {
    public func path(of rect: CGRect) -> UIBezierPath {
        switch self {
        case .rect: return UIBezierPath(rect: rect)
        case .circle: return UIBezierPath(ovalIn: rect)

        case .roundedRect(let radius):
            return UIBezierPath(roundedRect: rect, cornerRadius: radius)

        case let .singleLine(width, radius):
            let perferedRect = CGRect(
                x: 0,
                y: rect.midY - width / 2,
                width: rect.width,
                height: width
            )
            return UIBezierPath(roundedRect: perferedRect, cornerRadius: radius)

        case let .multipleLine(count, width, radius, spacing, lastPercent):
            let finalPath = UIBezierPath()
            for idx in 0..<count {
                let point = CGPoint(x: 0, y: CGFloat(idx) * (width + spacing))
                let size = CGSize(width: rect.width * (idx == count - 1 ? lastPercent : 1.0), height: width)
                let preferedRect = CGRect(origin: point, size: size)
                let path = UIBezierPath(roundedRect: preferedRect, cornerRadius: radius)
                finalPath.append(path)
            }

            return finalPath

        case let .dashRect(count, cornerRadius, spacing, direction):
            let finalPath: UIBezierPath
            switch direction {
            case .horizontal:
                finalPath = horizontalPaths(
                    of: rect,
                    count: count,
                    cornerRadius: cornerRadius,
                    spacing: spacing
                )

            case .vertical:
                finalPath = verticalPaths(
                    of: rect,
                    count: count,
                    cornerRadius: cornerRadius,
                    spacing: spacing
                )
            }
            return finalPath

        case let .cornerRect(corners):
            return UIBezierPath(bounds: rect, corners: corners)
        }
    }

    private func horizontalPaths(
        of bounds: CGRect,
        count: Int,
        cornerRadius: CGFloat,
        spacing: CGFloat
    ) -> UIBezierPath {
        let paths = UIBezierPath()
        let width = (bounds.width - CGFloat(count - 1) * spacing) / CGFloat(count)
        for idx in 0..<count {
            let rect = CGRect(x: CGFloat(idx) * (width + spacing), y: 0, width: width, height: bounds.height)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            paths.append(path)
        }

        return paths
    }

    private func verticalPaths(
        of bounds: CGRect,
        count: Int,
        cornerRadius: CGFloat,
        spacing: CGFloat
    ) -> UIBezierPath {
        let paths = UIBezierPath()
        let height = (bounds.height - CGFloat(count - 1) * spacing) / CGFloat(count)
        for idx in 0..<count {
            let rect = CGRect(x: 0, y: CGFloat(idx) * (height + spacing), width: bounds.width, height: height)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            paths.append(path)
        }

        return paths
    }
}
