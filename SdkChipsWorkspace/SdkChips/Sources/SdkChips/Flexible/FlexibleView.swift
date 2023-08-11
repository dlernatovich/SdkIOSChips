import SwiftUI

/// View which provide to show flexible items.
internal struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    /// Data to display.
    let data: Data
    /// Spacing.
    let spacing: CGFloat
    /// Alignment.
    let alignment: HorizontalAlignment
    /// Content.
    let content: (Data.Element) -> Content
    /// Available width.
    @State private var availableWidth: CGFloat = 0
    
    /// Instance of the {@link View}.
    var body: some View {
        ZStack(alignment: Alignment(horizontal: alignment, vertical: .center)) {
            Color.clear.frame(height: 1).readSize { size in
                availableWidth = size.width
            }
            FlexibleItem(
                availableWidth: availableWidth,
                data: data,
                spacing: spacing,
                alignment: alignment,
                content: content
            )
        }
    }
}
