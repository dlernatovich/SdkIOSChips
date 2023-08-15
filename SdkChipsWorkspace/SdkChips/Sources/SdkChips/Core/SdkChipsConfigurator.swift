import Foundation
import SwiftUI

/// Configurator for the Sdk Chips.
public final class SdkChipsConfigurator {
    
    /// Method which provide the configure functional.
    /// - Parameters:
    ///   - limit: limit of chips.
    ///   - tint: tint color.
    ///   - moreButtonTint: more button tint.
    ///   - corner: corner radius.
    public static func configure(
        limit: Int?,
        tint: Color,
        moreButtonTint: Color,
        corner: CGFloat
    ) {
        ChipsConfiguration.limit = limit
        ChipsConfiguration.tint = tint
        ChipsConfiguration.moreButtonTint = moreButtonTint
        ChipsConfiguration.corner = corner
    }
    
}
