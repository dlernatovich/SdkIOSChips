import Foundation
import SwiftUI

/// View which provide the chips displaying.
internal struct ChipsView : View {
    /// Array of the chips models.
    let chips: [Chip]
    /// {@link Bool} value if it is removable.
    let isRemovable: Bool
    /// Limit value.
    let limit: Int?
    /// {@link Color} value of the tint.
    let tint: Color
    /// {@link CGFloat} of the corner radius.
    let corner: CGFloat
    /// Click chip callback.
    let click: ChipClickCallback
    /// More click callback.
    let moreClick: MoreClickCallback?
    
    /// Instance of the body {@Link View}.
    var body: some View {
        FlexibleView(
            data: getChips(),
            spacing: SdkConstants.chipsPadding,
            alignment: .leading
        ) { item in
            ChipView(
                chip: item,
                isRemovable: isRemovable,
                tint: tint,
                corner: corner,
                click: click,
                moreClick: moreClick
            )
        }
        .padding(SdkConstants.chipsPadding)
        .listRowInsets(EdgeInsets())
    }
    
    /// Method which provide to get chips.
    /// - Returns: array of chips.
    private func getChips() -> [Chip] {
        var result: [Chip] = []
        result.append(contentsOf: chips)
        if isRemovable == true { result.removeAll(where: { $0.isSelected == false }) }
        if let limit = limit {
            let it = result.prefix(limit)
            result.removeAll()
            result.append(contentsOf: it)
        }
        if moreClick != nil { result.append(.moreChip) }
        return result
    }
}
