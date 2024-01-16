import Foundation
import SwiftUI

/// View which provide the chips displaying.
internal struct SectionsView : View {
    /// Array of the chips models.
    let sections: [ChipSection]
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
        if getSections().count > 0 {
            WrappingHStack(
                models: getSections(),
                viewGenerator: {
                    if $0.isMoreChip() == true {
                        ChipView(
                            type: .more,
                            model: $0,
                            imageName: nil,
                            moreCount: 0,
                            click: nil,
                            buttonClick: moreClick
                        )
                    } else {
                        ChipView(
                            type: isRemovable == true ? .chipSectionRemovable : .chipSection,
                            model: $0,
                            imageName: nil,
                            moreCount: 0,
                            click: click,
                            buttonClick: nil
                        )
                    }
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
    private func getSections() -> [ChipSection] {
        var result: [ChipSection] = []
        result.append(contentsOf: sections)
        if isRemovable == true { result.removeAll(where: { $0.isHasSelected() == false }) }
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
