import Foundation

@resultBuilder
public enum LayoutBuilder {
    public static func buildBlock(_ components: Layout...) -> [Layout] { components }
}
