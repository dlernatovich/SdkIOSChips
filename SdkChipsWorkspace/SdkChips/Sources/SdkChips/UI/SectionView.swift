import Foundation
import SwiftUI

/// Chips section view.
public struct SectionView : View {
    /// Instance of the {@link ChipSection}.
    var section: Binding<ChipSection>
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
    ///   - section: value.
    ///   - isRemovable: is removable.
    ///   - limit: limit tags value.
    ///   - tint: tint color.
    ///   - corner: corner radius.
    public init(
        section: Binding<ChipSection>,
        isRemovable: Bool,
        limit: Int?,
        tint: Color,
        corner: CGFloat
    ) {
        self.section = section
        self.isRemovable = isRemovable
        self.limit = limit
        self.tint = tint
        self.corner = corner
    }
    
    /// Instance of the {@link View}.
    public var body: some View {
        Section(header: Text(section.wrappedValue.title)) {
            ChipsView(
                chips: section.chips.wrappedValue,
                isRemovable: isRemovable,
                limit: limit,
                tint: tint,
                corner: corner,
                click: { chip in onClicked(chip) },
                moreClick: { }
            )
            .listRowInsets(EdgeInsets())
        }
    }
    
    /// Method which provide the action clicked.
    /// - Parameter chip: instance.
    private func onClicked(_ chip: Chip) {
        for i in 0..<section.wrappedValue.chips.count {
            if section.wrappedValue.chips[i].id == chip.id {
                section.wrappedValue.chips[i].isSelected.toggle()
                return
            }
        }
    }
    
}
