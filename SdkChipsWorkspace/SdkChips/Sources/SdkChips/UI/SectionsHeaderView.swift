import Foundation
import SwiftUI

/// Header view for the chips.
public struct SectionsHeaderView : View {
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
        SectionsView(
            sections: sections.wrappedValue,
            isRemovable: true,
            isNeedLimits: true,
            click: { onClicked($0, $1) },
            moreClick: moreClick
        )
    }
    
    /// Method which provide the action clicked.
    /// - Parameter chip: instance.
    private func onClicked(_ chip: Chip?, _ section: ChipSection?) {
        guard let section = section else { return }
        for i in 0..<sections.wrappedValue.count {
            if sections.wrappedValue[i].id == section.id {
                for j in 0..<sections.wrappedValue[i].chips.count {
                    sections.wrappedValue[i].chips[j].isSelected = false
                }
            }
        }
    }
}
