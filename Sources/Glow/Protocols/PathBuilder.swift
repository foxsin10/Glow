import UIKit

public protocol PathBuilder {
    func path(of rect: CGRect) -> UIBezierPath
}
