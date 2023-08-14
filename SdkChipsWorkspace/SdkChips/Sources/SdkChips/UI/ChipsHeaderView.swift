import Foundation
import SwiftUI

/// Header view for the chips.
public struct ChipsHeaderView : View {
    /// Instance of the {@link ChipSection}.
    var sections: Binding<[ChipSection]>
    /// Limit value.
    let limit: Int?
    /// {@link Color} value of the tint.
    let tint: Color
    /// {@link CGFloat} of the corner radius.
    let corner: CGFloat
    /// More click callback.
    let moreClick: MoreClickCallback?
    
    /// Default constructor.
    /// - Parameters:
    ///   - sections: sections array.
    ///   - limit: limit count.
    ///   - tint: tint color.
    ///   - corner: corner radius.
    ///   - moreClick: more click callback.
    public init(
        sections: Binding<[ChipSection]>,
        limit: Int?,
        tint: Color,
        corner: CGFloat,
        moreClick: MoreClickCallback?
    ) {
        self.sections = sections
        self.limit = limit
        self.tint = tint
        self.corner = corner
        self.moreClick = moreClick
    }
    
    /// Instance of the {@link View}.
    public var body: some View {
        ChipsView(
            chips: getChips(),
            isRemovable: true,
            limit: limit,
            tint: tint,
            corner: corner,
            click: { chip in onClicked(chip) },
            moreClick: moreClick
        )
    }
    
    /// Method which provide to get chips.
    /// - Returns: array of chips.
    private func getChips() -> [Chip] {
        sections.wrappedValue.flatMap { $0.chips }
    }
    
    /// Method which provide the action clicked.
    /// - Parameter chip: instance.
    private func onClicked(_ chip: Chip) {
        for i in 0..<sections.wrappedValue.count {
            for j in 0..<sections.wrappedValue[i].chips.count {
                if sections.wrappedValue[i].chips[j].id == chip.id {
                    sections.wrappedValue[i].chips[j].isSelected.toggle()
                }
            }
        }
    }
}
