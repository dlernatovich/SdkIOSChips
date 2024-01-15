import Foundation
import SwiftUI

/// Chips section view.
internal struct SectionView : View {
    /// Instance of the {@link ChipSection}.
    @Binding var section: ChipSection
    /// {@link Bool} value if it is removable.
    let isRemovable: Bool
    /// {@link Bool} value if it is need limits.
    let isNeedLimits: Bool
    /// More click callback.
    let moreClick: MoreClickCallback?
    /// Expand callback.
    let expandCallback: ExpandCallback?
    
    /// Instance of the {@link View}.
    internal var body: some View {
        DisclosureGroup(
            isExpanded: $section.isExpanded,
            content: {
                VStack {
                    ChipsView(
                        chips: section.chips,
                        isRemovable: isRemovable,
                        isNeedLimits: isNeedLimits,
                        click: { onClicked($0, $1) },
                        moreClick: moreClick
                    )
                }
                .listRowInsets(EdgeInsets())
                .fixedSize(horizontal: false, vertical: true)
            },
            label: {
                let count = getSelectedChipsCount()
                HStack {
                    HStack {
                        Text(section.title)
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
                        Rectangle().fill(Color.gray.opacity(0.001)).frame(maxWidth: .infinity)
                    }.onTapGesture {
                        section.isExpanded.toggle()
                        expandCallback?(section)
                    }
                    Button { onClearClicked() } label: {
                        Image("0d2cb41b-200b-4a87-8879-73610e98a632", bundle: .module)
//                            .padding(.leading, 16)
//                            .padding(.trailing, 8)
                            .padding(.horizontal, 8)
                    }
                }
            }
        )
    }
    
    /// Method which provide the action clicked.
    /// - Parameter chip: instance.
    private func onClicked(_ chip: Chip?, _ section: ChipSection?) {
        guard let chip = chip else { return }
        for i in 0..<self.section.chips.count {
            if self.section.chips[i].id == chip.id {
                self.section.chips[i].isSelected.toggle()
                return
            }
        }
    }
    
    /// Method which provide the clear clicked.
    private func onClearClicked() {
        for i in 0..<section.chips.count {
            section.chips[i].isSelected = false
        }
    }
    
    /// Method which provide to get selected chips count.
    /// - Returns: {@link Int} value of the selected chips.
    private func getSelectedChipsCount() -> Int {
        return section.chips.filter { $0.isSelected == true }.count
    }
    
}
