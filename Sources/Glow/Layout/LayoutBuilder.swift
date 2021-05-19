import Foundation

@resultBuilder
public enum LayoutBuilder {
    static func buildBlock(_ components: Layout...) -> [Layout] { components }
}
