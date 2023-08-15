import Foundation
import SwiftUI

/// Header view for the chips.
public struct ChipsHeaderView : View {
    /// Instance of the {@link ChipSection}.
    var sections: Binding<[ChipSection]>
    /// More click callback.
    let moreClick: MoreClickCallback?
    
    /// Default constructor.
    /// - Parameters:
    ///   - sections: sections array.
    ///   - moreClick: more click callback.
    public init(sections: Binding<[ChipSection]>, moreClick: MoreClickCallback?) {
        self.sections = sections
        self.moreClick = moreClick
    }
    
    /// Instance of the {@link View}.
    public var body: some View {
        ChipsView(
            chips: getChips(),
            isRemovable: true,
            isNeedLimits: true,
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
