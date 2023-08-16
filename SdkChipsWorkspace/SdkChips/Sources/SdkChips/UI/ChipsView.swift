import Foundation
import SwiftUI

/// View which provide the chips displaying.
internal struct ChipsView : View {
    /// Array of the chips models.
    let chips: [Chip]
    /// {@link Bool} value if it is removable.
    let isRemovable: Bool
    /// {@link Bool} value if is need limits.
    let isNeedLimits: Bool
    /// Limit value.
    private var limit: Int? { ChipsConfiguration.limit }
    /// {@link Color} value of the tint.
    private var tint: Color { ChipsConfiguration.tint }
    /// {@link Color} value for the more color.
    private var moreButtonTint: Color { ChipsConfiguration.moreButtonTint }
    /// {@link CGFloat} of the corner radius.
    private var corner: CGFloat { ChipsConfiguration.corner }
    /// Click chip callback.
    let click: ChipClickCallback
    /// More click callback.
    let moreClick: MoreClickCallback?
    
    /// Instance of the body {@Link View}.
    var body: some View {
        if getChips().count > 0 {
            WrappingHStack(
                models: getChips(),
                viewGenerator: {
                    ChipView(
                        chip: $0,
                        isRemovable: isRemovable,
                        click: click,
                        moreClick: moreClick
                    )
                }
            )
            .padding(SdkConstants.chipsPadding)
            .listRowInsets(EdgeInsets())
        } else {
            EmptyView()
        }
    }
    
    /// Method which provide to get chips.
    /// - Returns: array of chips.
    private func getChips() -> [Chip] {
        var result: [Chip] = []
        result.append(contentsOf: chips)
        if isRemovable == true { result.removeAll(where: { $0.isSelected == false }) }
        if isNeedLimits == true, let limit = limit {
            let previousCount = result.count
            let it = result.prefix(limit)
            result.removeAll()
            result.append(contentsOf: it)
            ChipsConfiguration.moreCount = previousCount - result.count
        }
        if moreClick != nil {
            let it = result
            result.removeAll()
            result.append(.moreChip)
            result.append(contentsOf: it)
        }
        return result
    }
}
