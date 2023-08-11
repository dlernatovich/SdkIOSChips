import SwiftUI

/// Extension which provide to read size.
internal extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { it in
                Color.clear.preference(key: SizePreferenceKey.self, value: it.size)
            }
        ).onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

/// Model for the size preferences.
private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
