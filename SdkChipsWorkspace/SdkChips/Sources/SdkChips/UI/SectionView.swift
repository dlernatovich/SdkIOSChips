import Foundation
import SwiftUI

/// Chips section view.
internal struct SectionView : View {
    /// Instance of the {@link ChipSection}.
    var section: Binding<ChipSection>
    /// {@link Bool} value if it is removable.
    let isRemovable: Bool
    /// {@link Bool} value if it is need limits.
    let isNeedLimits: Bool
    /// More click callback.
    let moreClick: MoreClickCallback?
    
    /// Instance of the {@link View}.
    internal var body: some View {
        Section(header: Text(section.wrappedValue.title)) {
            ChipsView(
                chips: section.chips.wrappedValue,
                isRemovable: isRemovable,
                isNeedLimits: isNeedLimits,
                click: { chip in onClicked(chip) },
                moreClick: moreClick
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
