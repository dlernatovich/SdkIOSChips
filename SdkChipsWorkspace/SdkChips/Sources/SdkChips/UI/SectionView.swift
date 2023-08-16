import Foundation
import SwiftUI

/// Chips section view.
internal struct SectionView : View {
    @State private var isExpanded: Bool = false
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
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                ChipsView(
                    chips: section.chips.wrappedValue,
                    isRemovable: isRemovable,
                    isNeedLimits: isNeedLimits,
                    click: { chip in onClicked(chip) },
                    moreClick: moreClick
                )
                .fixedSize(horizontal: false, vertical: true)
            },
            label: {
                let count = getSelectedChipsCount()
                HStack {
                    Text(section.wrappedValue.title)
                    if count > 0 {
                        ZStack {
                            RoundedRectangle(cornerRadius: ChipsConfiguration.corner)
                                .fill(ChipsConfiguration.tint)
                            Text(verbatim: "\(count)")
                                .font(.system(.caption2))
                                .fontWeight(.bold)
                                .foregroundColor(ChipsConfiguration.moreButtonBadgeTextTint)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                        }
                        .fixedSize(horizontal: true, vertical: true)
                    }
                }
            }
        )
        //        Section(header: Text(section.wrappedValue.title)) {
        //            ChipsView(
        //                chips: section.chips.wrappedValue,
        //                isRemovable: isRemovable,
        //                isNeedLimits: isNeedLimits,
        //                click: { chip in onClicked(chip) },
        //                moreClick: moreClick
        //            )
        //            .listRowInsets(EdgeInsets())
        //        }
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
    
    /// Method which provide to get selected chips count.
    /// - Returns: {@link Int} value of the selected chips.
    private func getSelectedChipsCount() -> Int {
        return section.wrappedValue.chips.filter { $0.isSelected == true }.count
    }
    
}
