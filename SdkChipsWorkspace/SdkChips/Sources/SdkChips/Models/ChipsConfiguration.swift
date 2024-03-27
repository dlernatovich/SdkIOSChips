import Foundation
import SwiftUI

/// Chips configuration model.
internal final class ChipsConfiguration {
    /// Instance of the {@link ChipsConfiguration}.
    private static var shared: ChipsConfiguration = .init()
    /// Limit value.
    var limit: Int? = nil
    /// Tint color.
    var tint: Color = .blue
    /// More button tint color.
    var moreButtonTint: Color = .gray
    /// More button tint color.
    var moreButtonBadgeTextTint: Color = Color(UIColor.secondarySystemBackground)
    /// Corner value.
    var corner: CGFloat = 8.0
    /// More count.
    var moreCount: Int = 0
    /// Limit value.
    static var limit: Int? {
        get { shared.limit }
        set(newValue) { shared.limit = newValue }
    }
    /// Tint color.
    static var tint: Color {
        get { shared.tint }
        set(newValue) { shared.tint = newValue }
    }
    /// More button tint color.
    static var moreButtonTint: Color {
        get { shared.moreButtonTint }
        set(newValue) { shared.moreButtonTint = newValue }
    }
    /// More button tint color.
    static var moreButtonBadgeTextTint: Color {
        get { shared.moreButtonBadgeTextTint }
        set(newValue) { shared.moreButtonBadgeTextTint = newValue }
    }
    /// Corner value.
    static var corner: CGFloat {
        get { shared.corner }
        set(newValue) { shared.corner = newValue }
    }
    /// More count.
    static var moreCount: Int {
        get { shared.moreCount }
        set(newValue) { shared.moreCount = max(0, newValue) }
    }
}
