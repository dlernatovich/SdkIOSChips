import Foundation
import SwiftUI

/// Chips sections view.
public struct SectionsMultilineView : View {
    /// Instance of the {@link ChipSection}.
    var sections: Binding<[ChipSection]>
    /// {@link Bool} value if it is removable.
    let isRemovable: Bool
    /// Limit value.
    let limit: Int?
    /// {@link Color} value of the tint.
    let tint: Color
    /// {@link CGFloat} of the corner radius.
    let corner: CGFloat
    
    /// Default constructor.
    /// - Parameters:
    ///   - sections: sections array.
    ///   - isRemovable: is removable.
    ///   - limit: limit of tags.
    ///   - tint: tint color.
    ///   - corner: corner radius.
    public init(
        sections: Binding<[ChipSection]>,
        isRemovable: Bool,
        limit: Int?,
        tint: Color,
        corner: CGFloat
    ) {
        self.sections = sections
        self.isRemovable = isRemovable
        self.limit = limit
        self.tint = tint
        self.corner = corner
    }
    
    /// Instance of the {@link View}.
    public var body: some View {
        ChipsView(
            chips: getChips(),
            isRemovable: isRemovable,
            limit: limit,
            tint: tint,
            corner: corner,
            click: { chip in onClicked(chip) },
            moreClick: { }
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
