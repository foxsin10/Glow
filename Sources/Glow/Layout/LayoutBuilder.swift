import Foundation

@_functionBuilder
enum LayoutBuilder {
    static func buildBlock(_ components: Layout...) -> [Layout] {
        return components
    }
}
